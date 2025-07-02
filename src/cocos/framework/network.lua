
local network = {}

function network.createHTTPRequest(callback, url, method)
    if not method then method = "GET" end
    if string.upper(tostring(method)) == "GET" then
        method = cc.kCCHTTPRequestMethodGET
    else
        method = cc.kCCHTTPRequestMethodPOST
    end
    return cc.HTTPRequest:createWithUrl(callback, url, method)
end

return network
