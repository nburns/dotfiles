function vm
    set running (vboxmanage list runningvms)
    if string_contains "$running" 'dev'
        # nothing, machine is running
    else
	    vboxmanage startvm dev --type headless
        while not ping -c 1 local.instaedu.com > /dev/null
            sleep 2
        end
    end

    clear

	ssh instaedu@local.instaedu.com
end
