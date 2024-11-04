
---@class fgui.UIPackage :cc.Ref
local UIPackage={ }
fgui.UIPackage=UIPackage




---* 
---@return string
function UIPackage:getName () end
---* 
---@return string
function UIPackage:getId () end
---* 
---@param itemName string
---@return fgui.PackageItem
function UIPackage:getItemByName (itemName) end
---* 
---@param itemId string
---@return fgui.PackageItem
function UIPackage:getItem (itemId) end
---* 
---@param url string
---@return fgui.GObject
function UIPackage:createObjectFromURL (url) end
---* 
---@param packageIdOrName string
---@return self
function UIPackage:removePackage (packageIdOrName) end
---* 
---@param pkgName string
---@param resName string
---@return string
function UIPackage:getItemURL (pkgName,resName) end
---* 
---@param url string
---@return string
function UIPackage:normalizeURL (url) end
---* 
---@param key string
---@return string
function UIPackage:getVar (key) end
---* 
---@return self
function UIPackage:removeAllPackages () end
---* 
---@param pkgName string
---@param resName string
---@return fgui.GObject
function UIPackage:createObject (pkgName,resName) end
---* 
---@param url string
---@param type int
---@return void
function UIPackage:getItemAssetByURL (url,type) end
---* 
---@param name string
---@return self
function UIPackage:getByName (name) end
---* 
---@param descFilePath string
---@return self
function UIPackage:addPackage (descFilePath) end
---* 
---@param id string
---@return self
function UIPackage:getById (id) end
---* 
---@return string
function UIPackage:getBranch () end
---* 
---@param value string
---@return self
function UIPackage:setBranch (value) end
---* 
---@param url string
---@return fgui.PackageItem
function UIPackage:getItemByURL (url) end
---* 
---@return cc.Texture2D
function UIPackage:getEmptyTexture () end
---* 
---@param key string
---@param value string
---@return self
function UIPackage:setVar (key,value) end
---* 
---@return self
function UIPackage:UIPackage () end