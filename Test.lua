local Env = getfenv()

xpcall(function()
    return game:_____()
end, function()
    for i = 0, 10 do
        if getfenv(i) ~= Env then
            warn("Detected metamethod tampering!")
        end
    end
end)

local OldErr, OldMsg = pcall(function() return game:____() end)

while wait(1) do
    local Err, Msg = pcall(function() return game:____() end)

    if OldErr ~= Err or OldMsg ~= Msg then
        warn("Detected metamethod tampering!")
    end
end
