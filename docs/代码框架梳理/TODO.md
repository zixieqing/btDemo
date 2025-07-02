### 拓展组件注册时，无法保存handler 问题
后边再研究，我想从lua中传过来一个类，mailItem, 在cpp,这边new,并保存onConstruct,在组件Component->onConstruct时调用lua的onConstruct


目前先手动传方法过去吧

```cpp
static int lua_cocos2dx_fairygui_UIObjectFactory_registComponent(lua_State* tolua_S)
{
	int argc = 0;

#if COCOS2D_DEBUG >= 1
	tolua_Error tolua_err;
	if (!tolua_isusertable(tolua_S, 1, "fgui.UIObjectFactory", 0, &tolua_err) ||
		!tolua_isstring(tolua_S, 2, 0, &tolua_err) ||
		!tolua_istable(tolua_S, 3, 0,&tolua_err) ||
		!tolua_istable(tolua_S, 4, 0, &tolua_err))
	{
		goto tolua_lerror;
	}
#endif
	argc = lua_gettop(tolua_S) - 1;
	if (argc == 2) {
		std::string url;
		luaval_to_std_string(tolua_S, 2, &url, "fgui.UIObjectFactory:setPackageItemExtension");
		
		
		//fairygui::UIObjectFactory* self = static_cast<UIObjectFactory*>(tolua_tousertype(tolua_S, 1, 0));


		//int error22 = lua_pcall(tolua_S, 0, 0, 0); // 1 pararm, 1 return
		/*LuaStack* stack = LuaEngine::getInstance()->getLuaStack();
		int topElementType2 = lua_type(stack->getLuaState(), -1);
		stack->executeFunctionByHandler(handler, 0);*/
		//stack->executeFunction(0);

		//lua_pop(tolua_S, 1);
		fairygui::GComponent* com = static_cast<fairygui::GComponent*>(tolua_tousertype(tolua_S, -1, 0));
		lua_pop(tolua_S, 1);

		//lua_getfield(tolua_S, -1, "testycf");
		//lua_pushvalue(tolua_S, -1);
		//LUA_FUNCTION handler = toluafix_ref_function(tolua_S, -1, 0);
		///*ScriptHandlerMgr::getInstance()->addCustomHandler((void*)com, handler);*/
		
		// 从 Lua 表中获取函数
		lua_getfield(tolua_S, -1, "testycf");
		// 从 Lua 表中获取函数

		if (lua_isfunction(tolua_S, -1)) {
			// 创建一个新的 Lua 函数
			lua_pushcclosure(tolua_S, lua_call_function, 1);

			// 将新的 Lua 函数压入栈顶
			lua_pushvalue(tolua_S, -1);

			// 使用 toluafix_ref_function 保存函数引用
			LUA_FUNCTION handler = toluafix_ref_function(tolua_S, -1, 0);

			// 现在可以使用 handler 来调用 Lua 函数
			LuaStack* stack = LuaEngine::getInstance()->getLuaStack();
			stack->pushFunctionByHandler(handler);
		}




		//lua_pop(tolua_S, 1);
		fairygui::UIObjectFactory::setPackageItemExtension(url, [=]() -> fairygui::GComponent* {

			LuaStack* stack = LuaEngine::getInstance()->getLuaStack();
			//stack->pushFunctionByHandler(handler);
			//toluafix_get_function_by_refid(stack->getLuaState(), handler);
			int topElementType = lua_type(stack->getLuaState(), -1);
			CCLOG("[LUA ERROR] %s", lua_tostring(stack->getLuaState(), -1));
			//stack->executeFunctionByHandler(handler, 0);

			//CCLOG("[LUA 111] %s", lua_tostring(tolua_S, -1));
			//lua_getfield(tolua_S, -1, "testycf");
			//int error = lua_pcall(tolua_S, 0, 0, 0); // 1 pararm, 1 return
			//if (error) {
			//	CCLOG("[LUA ERROR] %s", lua_tostring(tolua_S, -1));
			//	lua_pop(tolua_S, 1); // remove error message from stack
			//	return 0;
			//}
			/*LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 0, 0);*/
			return com;
		});



		//lua_getfield(tolua_S, -1, "testycf");
		//LUA_FUNCTION handler = toluafix_ref_function(tolua_S, 0, 0);

		////toluafix_get_function_by_refid(tolua_S, handler);
		//LuaStack* _stack = LuaEngine::getInstance()->getLuaStack();
		////lua_pushstring(tolua_S, "j13l3");
		//_stack->executeFunctionByHandler(handler, 0);


		//ScriptHandlerMgr::getInstance()->addObjectHandler((void*)com, handler, ScriptHandlerMgr::HandlerType::EVENT_FGUI_COMPONENT_REGISTER);


			//toluafix_get_function_by_refid(tolua_S, handler);
		// 将需要传递的参数压入栈
		//if (lua_pcall(tolua_S, 1, 0, 0) != 0) {
		//	// 处理函数调用错误
		//	std::string errorMessage = lua_tostring(tolua_S, -1);
		//	lua_pop(tolua_S, 1); // 弹出错误信息
		//	// 在这里处理错误, 例如记录日志或者抛出异常
		//}

		//int error2 = lua_pcall(tolua_S, 0, 0, 0); // 1 pararm, 1 return
		//if (lua_isfunction(tolua_S, 0)) {
		//LuaStack* _stack = LuaEngine::getInstance()->getLuaStack();
		//_stack->executeFunctionByHandler(handler, 0);
			//if (lua_pcall(tolua_S, 1, 0, 0) != 0) {
			//	// 处理函数调用错误
			//	std::string errorMessage = lua_tostring(tolua_S, -1);
			//	lua_pop(tolua_S, 1); // 弹出错误信息
			//	// 在这里处理错误, 例如记录日志或者抛出异常
			//}

		//}
		
		//lua_pop(tolua_S, 1); 

		
		return 0;
	}
	luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d", "fgui.UIObjectFactory:setPackageItemExtension", argc, 2);
	return 0;

#if COCOS2D_DEBUG >= 1
	tolua_lerror:
	tolua_error(tolua_S, "#ferror in function 'lua_fairygui_UIObjectFactory_setPackageItemExtension'.", &tolua_err);
	return 0;
#endif
}

```

### TODO 
-- 测试fairygui关联系统与应用