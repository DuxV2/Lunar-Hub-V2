-- old

local OldFireServer

OldFireServer = hookfunction(Instance.new('RemoteEvent').FireServer, newcclosure(function(Event, ...)
    if not checkcaller() then
        local Args = {...}

        print(Event)
        for I, V in pairs(Args) do
            print(V)
        end
    end

    return OldFireServer(Event, ...)
end))

-- new

function remotelog(obj, args, caller)
    print(obj, unpack(args), caller)
end 
local MT = getrawmetatable(game)
make_writeable(MT)
local NC = MT.__namecall
MT.__namecall =
    newcclosure(
    function(obj, ...)
        if obj.ClassName == "RemoteEvent" or obj.ClassName == "RemoteFunction" then
            remotelog(obj, {...}, getfenv().script)
        end
        return NC(obj, ...)
    end
)

-- newer
 
local old
old =
    hookmetamethod(
    game,
    "__namecall",
    function(self, ...)
        local args = {...}
        local event = self
        local namecallmethod = getnamecallmethod()
        if namecallmethod == "FireServer" or namecallmethod == "InvokeServer" then
            rconsoleprint("-------------------------\n")
            rconsoleprint("REMOTE EVENT\n")
            rconsoleprint("event: " .. self:GetFullName() .. "\n")
            rconsoleprint("method: " .. getnamecallmethod() .. "\n")
            rconsoleprint("args:\n")
            for i, v in pairs(args) do
                rconsoleprint("- " .. tostring(v) .. "\n")
            end
            rconsoleprint("-------------------------\n")
        end
        return old(self, ...)
    end
)
