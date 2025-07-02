--【聊天场景】
local DemoScene = require("fairyGUI.views.DemoScene")

local ChatScene = class("ChatScene",  DemoScene)
function ChatScene:ctor()
    ChatScene.super.ctor(self)
end

function ChatScene:initVars()
    self._input = nil
    self._list = nil 
    self._emojiSelectUI = nil
    self._messages = {}
end

function ChatScene:continueInit()
    fgui.UIPackage:addPackage("fairyGUIDemo/Emoji")
    local _view = fgui.UIPackage:createObject("Emoji", "Main")
    self._groot:addChild(_view)
    self._list = _view:getChild("list");
    self._list:setVirtual();
    self._list:setItemProvider(handler(self, self.getListItemResource));
    self._list:setItemRenderer(handler(self, self.renderListItem));

    self._input = _view:getChild("input");
    self._input:addEventListener(fgui.UIEventType.Submit, handler(self, self.onSubmit));

    _view:getChild("btnSend"):addClickListener(handler(self, self.onClickSendBtn));
    _view:getChild("btnEmoji"):addClickListener(handler(self, self.onClickEmojiBtn));

    self._emojiSelectUI = fgui.UIPackage:createObject("Emoji", "EmojiSelectUI")
    self._emojiSelectUI:retain();
    self._emojiSelectUI:getChild("list"):addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onClickEmoji));
end

function ChatScene:getListItemResource(index)
    local msg = self._messages[index];
    if (msg.fromMe) then
        return "ui://Emoji/chatRight";
    else
        return "ui://Emoji/chatLeft";
    end
end

function ChatScene:renderListItem(index, obj)
    local msg = self._messages[index + 1];
    local tf = obj:getChild("msg")

    if (not msg.fromMe) then
        obj:getChild("name"):setText(msg.sender);
    end
    obj:setIcon("ui://Emoji/" .. msg.senderIcon);

    tf:setText("");
    
    print("tf.initSize.width",tf.initSize.width)
    tf:setWidth(tf.initSize.width);
    tf:setText(msg.msg)
    -- tf:setText(EmojiParser::getInstance():parse(msg)); --TODO 表情包解析后续再做
    tf:setWidth(tf:getTextSize().width);
end

function ChatScene:onClickSendBtn()
    print("function ChatScene:onClickSendBtn()")
    local msg = self._input:getText();
    if msg == "" then return end
    self:addMsg("Unity", "r0", msg, true);
    self._input:setText("");
end

function ChatScene:onClickEmojiBtn(context)
    print("function ChatScene:onClickEmojiBtn()")
    self._groot:showPopup(self._emojiSelectUI, context:getSender(), fgui.PopupDirection.UP);
end

function ChatScene:onClickEmoji(context)
    print("function ChatScene:onClickEmoji()")
    local item = context:getData();
    local emojStr = string.format("%s[:\"%s\"]",self._input:getText(), item:getText())
    self._input:setText(emojStr);
end

function ChatScene:addMsg(sender, senderIcon, msg, fromMe)

    local isScrollBottom = self._list:getScrollPane():isBottomMost();
    local  newMessage = {};
    newMessage.sender = sender;
    newMessage.senderIcon = senderIcon;
    newMessage.msg = msg;
    newMessage.fromMe = fromMe;
    table.insert(self._messages, newMessage)

    if (newMessage.fromMe) then
    
        if (table.nums(self._messages) == 1 or math.random() < 0.5) then
            local replyMessage = {};
            replyMessage.sender = "FairyGUI";
            replyMessage.senderIcon = "r1";
            replyMessage.msg = "Today is a good day. [:cool]";
            replyMessage.fromMe = false;
            table.insert(self._messages, replyMessage)
        end
    end

    if (table.nums(self._messages) > 100) then
        for i = 1, 100 do
            table.remove(messages, i)
        end
    end
    self._list:setNumItems(table.nums(self._messages));

    if (isScrollBottom) then
        self._list:getScrollPane():scrollBottom(true);
    end
end


function ChatScene:onExit()
    print("ChatScene:onExit()")
    fgui.UIPackage:removePackage("fairyGUIDemo/Emoji")  -- 看项目需求，如果不经常使用的建议退出的时候移除包，避免内存长期占用问题
    ChatScene.super.onExit(self)  --如果子类有实现onExit 请调用super.onExit(self) ；如果没有实现可以不添加onExit该方法
end

function ChatScene:onEnter()
    print("ChatScene:onEnter()")
end

function ChatScene:onClear()
    print("ChatScene:onClear()")
end

return ChatScene