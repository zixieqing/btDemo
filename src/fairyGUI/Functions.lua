function CC_SAFE_RELEASE(obj)
    if obj and tolua.isnull(obj) ~= nil then
        obj:release()
    end
end

function CC_SAFE_RELEASE(obj)
    if obj and tolua.isnull(obj) ~= nil then
        obj:release()
    end
end


function CC_SAFE_RETAIN(obj)
    if obj and tolua.isnull(obj) ~= nil then
        obj:retain()
    end
end

