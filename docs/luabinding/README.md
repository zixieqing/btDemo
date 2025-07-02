### 常用方法，及参数功能

#### luabinding
```cpp
//导出属性
tolua_variable(L, "id", lua_get_fairygui_GObject_id, lua_get_fairygui_GObject_id);

static int lua_get_fairygui_GObject_id(lua_State* L)
{
    fairygui::GObject* self = nullptr;
    self = (fairygui::GObject*)  tolua_tousertype(L,1,0);
    lua_pushstring(L, self->id.c_str());
    return 1;
}

static int lua_get_fairygui_GObject_sourceSize(lua_State* L)
{
    fairygui::GObject* self = nullptr;
    self = (fairygui::GObject*)  tolua_tousertype(L,1,0);
	size_to_luaval(L, self->getSourceSize()); //假如是size 属性，需要对应转换，查看：LuaBasicConversions.cpp
    return 1;
}

tolua_variable(L, "maxSize", lua_get_fairygui_GObject_maxSize, NULL); //(Lua虚拟机， "lua func name", 读方法， 写方法)


//传入有回调且带参数的
static int lua_cocos2dx_fairygui_addEventListener(lua_State* L)
{
	if (nullptr == L)
		return 0;

	int argc = 0;
	fairygui::UIEventDispatcher* self = nullptr;

	self = static_cast<fairygui::UIEventDispatcher*>(tolua_tousertype(L, 1, 0));

	argc = lua_gettop(L) - 1;

	if (2 == argc)
	{
		LUA_FUNCTION handler = (toluafix_ref_function(L, 3, 0));  //3 表示第 3 个参数,也就是 Lua 脚本中传递的第 3 个参数。
        /*
            如：
            --这里是第二个参数，但是使用： 访问，第一个参数是self, 所以handler即回调方法，即就是3
            --假如用.访问就是2
            obj:addEventListener(eventtype, function() 
            end)

            --0 的话看源码没有用到

        */

		bool ok = true;
		int eventType;
		ok &= luaval_to_int32(L, 2, (int *)&eventType, "lua_cocos2dx_fairygui_addEventListener");

		self->addEventListener(eventType, [=](fairygui::EventContext* sender) {
			handleFairyguiEvent(handler, sender);
		});
		ScriptHandlerMgr::getInstance()->addCustomHandler((void*)self, handler);

		return 0;
	}
	if (3 == argc)
	{
		LUA_FUNCTION handler = (toluafix_ref_function(L, 3, 0));

		bool ok = true;
		int eventType;
		ok &= luaval_to_int32(L, 2, (int *)&eventType, "lua_cocos2dx_fairygui_addEventListener");

		int tag;
		ok &= luaval_to_int32(L, 4, (int *)&tag, "lua_cocos2dx_fairygui_addEventListener");

		self->addEventListener(eventType, [=](fairygui::EventContext* sender) {
			handleFairyguiEvent(handler, sender);
		}, fairygui::EventTag(tag));
		ScriptHandlerMgr::getInstance()->addCustomHandler((void*)self, handler);

		return 0;
	}

	return 0;
}


static int handleFairyguiEvent(int handler, fairygui::EventContext* sender)
{
	LuaStack* stack = LuaEngine::getInstance()->getLuaStack();
	//tolua_pushusertype(stack->getLuaState(), (void*)sender, "fgui.EventContext");
	object_to_luaval<fairygui::EventContext>(stack->getLuaState(), "fgui.EventContext", (fairygui::EventContext*)sender);//push进去
	stack->executeFunctionByHandler(handler, 1); //第一个参数是具体的函数， 1代表这个回调函数所接受的参数数量
	stack->clean();
	return 0;
}


//3.今天接触一个需要拿到lua那边执行完返回过来的return值
static int lua_cocos2dx_fairygui_GList_setItemProvider(lua_State* L)
{
	if (nullptr == L)
		return 0;

	int argc = 0;
	fairygui::GList* self = nullptr;

	self = static_cast<fairygui::GList*>(tolua_tousertype(L, 1, 0));

	argc = lua_gettop(L) - 1;

	if (1 == argc)
	{
		LUA_FUNCTION handler = (toluafix_ref_function(L, 2, 0)); //回调函数在参数的第二个位置
		LuaStack* stack = LuaEngine::getInstance()->getLuaStack();

		self->itemProvider = std::function<std::string(int)>([stack, handler, L](int index) {
			stack->pushInt(index + 1); //lua那边从1开始，进行加1
			__Array pRetArray;
			pRetArray.initWithCapacity(1);
			int ret = stack->executeFunctionReturnArray(handler, 1, 1, pRetArray); //通过这个方法就可以获取到lua执行完回调函数的返回值
			if (ret > 0 && pRetArray.count() > 0) {
				__String* str = (__String*)pRetArray.getObjectAtIndex(0);
				const char* result = str->getCString();
				return std::string(result);
			}
			else
			{
				luaL_error(L, "setItemProvider get callback return value is null, please check it");
				return std::string("this is a error string");
			}
			});

		ScriptHandlerMgr::getInstance()->addCustomHandler((void*)self, handler);
		return 0;
	}

	return 0;


#endif
}



```

### cpp 知识学习

1.枚举常量
枚举常量代表该枚举类型的变量可能取的值，编译系统为每个枚举常量指定一个整数值，默认状态下，这个整数就是所列举元素的序号，序号从0开始
enum fruit_set {apple, orange, banana=1, peach, grape}
//枚举常量apple=0,orange=1, banana=1,peach=2,grape=3。

2.c++ 用. 和 -> 的区别

对象指针访问:
使用箭头运算符(->)是通过【指向对象的指针】来访问成员。例如: pointer->member
使用点运算符(.)是通过【对象本身】来访问成员。例如: object.member

```cpp

class GObject : public UIEventDispatcher
{
public:
    static GObject* getDraggingObject() { return _draggingObject; }

    GObject();
    virtual ~GObject();
    std::string id;
    std::string name;
    cocos2d::Size sourceSize;
    cocos2d::Size initSize;
    cocos2d::Size minSize;
    cocos2d::Size maxSize;

}


static int lua_get_fairygui_GObject_name(lua_State* L)
{
    fairygui::GObject* self = nullptr;

    self = (fairygui::GObject*)  tolua_tousertype(L,1,0); //self就是一个指向对象的指针

    lua_pushstring(L, self->name().c_str()); //所以这里用->访问 ,不能
    // 这样写也可以  lua_pushstring(L, self->name.c_str());
    /*
    【问题：self->name.c_str() 和self->name().c_str() 为什么都可以编译通过】   错误哦，self.name().c_str() 编译不过哦
    这里的这种写法困惑了好久：
    对于 obj->name().c_str()

    即使 name 是一个成员变量,而不是成员函数,编译器也会自动将其隐式地转换为 (obj->name()).c_str()。
    这是因为在 C++ 中,当我们使用 () 来访问一个对象时,编译器会尝试调用该对象的 operator() 重载函数,如果没有找到,则会尝试访问该对象的成员变量。
    在这种情况下,name 虽然是一个成员变量,但编译器会自动将其视为一个临时的 std::string 对象,然后再调用 c_str() 方法。
    对于 obj->name.c_str()

    这种写法是正确的,因为它直接通过指针访问 name 成员变量,然后调用 std::string 的 c_str() 方法。
    总的来说,C++ 编译器在处理这种看似不正确的语法时,会尝试进行一些隐式的转换和解析,以维持代码的可编译性。

    但是,虽然这两种写法都能通过编译,但更推荐使用 obj->name.c_str() 这种直接访问成员变量的方式,因为它更加清晰和直观,不会依赖于编译器的隐式转换行为。


    */


    /*
        2.新的问题：self->name() 和self->name().c_str() 为什么前者会报错：C++ 在没有适当 operator() 的情况下调用类类型的对象或将函数转换到指向函数的类型
        self->name()

        详细见luabinding/operator

    */
    return 1;
}

TOLUA_API void* tolua_tousertype (lua_State* L, int narg, void* def)
{
    if (lua_gettop(L)<abs(narg))
        return def;
    else
    {
        void* u;
        if (!lua_isuserdata(L, narg)) {
            if (!push_table_instance(L, narg)) return NULL;
        };
        u = lua_touserdata(L,narg);
        return (u==NULL) ? NULL : *((void**)u); /* nil represents NULL */  //u 最终是一个指向某个 C++ 对象的 void* 类型的指针
    }
}


// 【对象本身用 .】
class MyClass {
public:
    int myVariable;
    void myFunction() {
        // ...
    }
};

int main() {
    MyClass obj;
    obj.myVariable = 10; // 通过对象访问成员变量
    obj.myFunction(); // 通过对象调用成员函数

    MyClass* ptr = &obj;
    ptr->myVariable = 20; // 通过指针访问成员变量
    ptr->myFunction(); // 通过指针调用成员函数

    return 0;
}


int error = lua_pcall(tolua_S, 0, 1, 0);
tolua_S: 这是 Lua 状态机的指针,用于执行 Lua 代码。
0: 这是参数个数,表示没有传入任何参数给Lua函数。
1: 这是期望的返回值个数,表示期望函数返回1个值。
0: 这是一个错误处理函数的索引,表示使用默认的错误处理函数。




```