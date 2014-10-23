function restart_vm
    if ping -c 1 local.instaedu.com > /dev/null
        ssh instaedu@local.instaedu.com 'iedu_restart; exit;'
    end
end
