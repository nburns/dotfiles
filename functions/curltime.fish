function curltime
    set url $argv[1]
    echo $url
    curl -o /dev/null -s -w '%{time_total}\\n' $url
end
