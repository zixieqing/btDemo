#### 1.registerCompnent url
一定要对,不然会引发奇怪的问题


#### 2.组件如果仅作为界面，可设置穿透
不然会影响window 的移动触摸，会卡卡的

#### richText 文本模版
a=xxxx 不能有空格


####  3.C++ 释放lua中的引用
**getItemByURL** 要慎用
toluafix.h
toluafix_remove_ccobject_by_refid 
总的来说，这个函数用于清理 Lua 中 C++ 对象的引用关系,确保对象被正确地从 Lua 中移除,避免内存泄漏。它是 tolua 这个库中 C++/Lua 绑定的一个重要组件。
遇到一个问题：
在： 此处增加打印，会看到相关lua 信息
```c
// 删除 tolua_refid_type_mapping 之前
printf("Lua stack before delete refid_type[%d]: %d\n", refid, lua_gettop(L));
for (int i = 1; i <= lua_gettop(L); i++) {
    printf("  [%d] %s", i, lua_typename(L, lua_type(L, i)));

    // 尝试获取变量名称
    const char* name = NULL;
    int top = lua_gettop(L);
    for (int i = 1; i <= top; i++) {
        if (lua_type(L, i) == LUA_TSTRING) {
            name = lua_tostring(L, i);
            printf(" (%s)", name);
            break;
        }
    }
}
```

```lua
---@param extensiton class
function fgui.registerComponent(url, extensiton)
    if DEBUG > 0 then
        local item  = fgui.UIPackage:getItemByURL(url) --这句：引用的没有释放：导致removePackage时会引发占用问题
        assert(item, string.format("[error] function 'fgui.registerComponent' url:[%s] is not exist, fix path correct.", url)) 
        local checkUrlItem  = fgui.UIPackage:createObjectFromURL(url)
        assert(checkUrlItem, string.format("[error] function 'fgui.registerComponent' url:[%s] is not exist, fix path correct.", url))
    end
    fgui.UIObjectFactory:registComponent(url, function()
        return extensiton.new()
    end)
end
```


####  4.package过大，会引发UI显示异常
Common过大 就会导致列表出现染色问题



