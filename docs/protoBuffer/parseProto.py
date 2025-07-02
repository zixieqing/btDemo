from pathlib import Path
import os
import re
import lupa
import collections


current_dir = Path(__file__).parent
lua_file_path = os.path.join(os.path.dirname(__file__), "messages.lua")
clientdef_file_path = os.path.join(os.path.dirname(__file__), "clientDef.lua")

def _ParseProtoFile():
    print(current_dir)


    file_path = os.path.join(current_dir, "wildbtmessage/netcmd.proto")
    with open(file_path, 'r', encoding='utf-8') as file:
        sample_message = file.read()

    def extract_messages(message):
        pattern = r"message\s+(\w+)"
        return re.findall(pattern, message)

    messages = extract_messages(sample_message)
    print(messages)  # 输出: ['AppearMapProperty', 'ObjAppear']

    # 将消息名称写入到 Lua 文件中
    with open(lua_file_path, 'w') as lua_file:
        lua_file.write("return {\n")
        for index, message in enumerate(messages):
            if not "S2C" in message:
                lua_file.write(f"    [{index + 1}] = {{ proto = \"{message}\", reqID = 0, }},\n")
        lua_file.write("}")

def _FindIDByKey(protoKey):
    with open(clientdef_file_path, 'r', encoding='utf-8') as f:
        lua_code = f.read()

    lua = lupa.LuaRuntime()

    my_table = lua.execute(lua_code)
    
    for cmdKey, value in my_table.items():
        cmdKeyRe = "000000000000"
        protoKeyRe = "1111111111111"
        if "C_" in cmdKey:
            cmdKeyRe = cmdKey.split("C_")[1]
        if "C2S_" in protoKey:    
            protoKeyRe = protoKey.split("C2S_")[1]
       
        if cmdKey == protoKey.upper() or cmdKey == protoKeyRe or cmdKeyRe == protoKeyRe or cmdKeyRe == protoKey.upper():
            print("_FindIDByKey", protoKey, protoKeyRe, cmdKeyRe, cmdKey, value)
            return value
    return 0
        
def _WriteClientProtoId():

    with open(lua_file_path, 'r') as f:
        lua_code = f.read()

    lua = lupa.LuaRuntime()

    new_messages = []
    messages = lua.table_from(lua.execute(lua_code)).values()
    for index, message in enumerate(messages):
        new_value = _FindIDByKey(message.proto)
        new_message = collections.OrderedDict()
        new_message["proto"] = message.proto
        new_message["reqID"] = new_value
        new_messages.append(new_message)
    

    with open("ReqID.lua", 'w') as lua_file:
        lua_file.write("return {\n")
        for index, message in enumerate(new_messages):
            lua_file.write(f"    [{index + 1}] = {{ proto = \"{message["proto"]}\", reqID = {message["reqID"]}, }},\n")
        lua_file.write("}")

    
_ParseProtoFile()
_WriteClientProtoId()


