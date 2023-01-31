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
