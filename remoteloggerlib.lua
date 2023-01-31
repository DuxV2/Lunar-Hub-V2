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
