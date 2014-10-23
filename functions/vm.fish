function vm
    if string_contains (vboxmanage list runningvms) 'dev' > /dev/null
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
