
---@class cc.CCBReader :cc.Ref
local CCBReader={ }
cc.CCBReader=CCBReader




---* 
---@param name string
---@return self
function CCBReader:addOwnerOutletName (name) end
---* 
---@return array_table
function CCBReader:getOwnerCallbackNames () end
---* 
---@param eventType int
---@return self
function CCBReader:addDocumentCallbackControlEvents (eventType) end
---* 
---@param ccbRootPath char
---@return self
function CCBReader:setCCBRootPath (ccbRootPath) end
---* 
---@param node cc.Node
---@return self
function CCBReader:addOwnerOutletNode (node) end
---* 
---@return array_table
function CCBReader:getOwnerCallbackNodes () end
---* 
---@param seq cc.CCBSequence
---@return boolean
function CCBReader:readSoundKeyframesForSeq (seq) end
---* 
---@return string
function CCBReader:getCCBRootPath () end
---* 
---@return array_table
function CCBReader:getOwnerCallbackControlEvents () end
---* 
---@return array_table
function CCBReader:getOwnerOutletNodes () end
---* 
---@return string
function CCBReader:readUTF8 () end
---* 
---@param type int
---@return self
function CCBReader:addOwnerCallbackControlEvents (type) end
---* 
---@return array_table
function CCBReader:getOwnerOutletNames () end
---* js setActionManager<br>
---* lua setActionManager
---@param pAnimationManager cc.CCBAnimationManager
---@return self
function CCBReader:setAnimationManager (pAnimationManager) end
---* 
---@param seq cc.CCBSequence
---@return boolean
function CCBReader:readCallbackKeyframesForSeq (seq) end
---* 
---@return array_table
function CCBReader:getAnimationManagersForNodes () end
---* 
---@return array_table
function CCBReader:getNodesWithAnimationManagers () end
---* js getActionManager<br>
---* lua getActionManager
---@return cc.CCBAnimationManager
function CCBReader:getAnimationManager () end
---* 
---@param scale float
---@return self
function CCBReader:setResolutionScale (scale) end
---@overload fun(cc.NodeLoaderLibrary0:cc.CCBReader):self
---@overload fun(cc.NodeLoaderLibrary:cc.NodeLoaderLibrary,cc.CCBMemberVariableAssigner:cc.CCBMemberVariableAssigner,cc.CCBSelectorResolver:cc.CCBSelectorResolver,cc.NodeLoaderListener:cc.NodeLoaderListener):self
---@overload fun():self
---@param pNodeLoaderLibrary cc.NodeLoaderLibrary
---@param pCCBMemberVariableAssigner cc.CCBMemberVariableAssigner
---@param pCCBSelectorResolver cc.CCBSelectorResolver
---@param pNodeLoaderListener cc.NodeLoaderListener
---@return self
function CCBReader:CCBReader (pNodeLoaderLibrary,pCCBMemberVariableAssigner,pCCBSelectorResolver,pNodeLoaderListener) end