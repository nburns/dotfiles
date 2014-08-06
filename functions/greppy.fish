function greppy
    set regex $argv[1]
    set regex "*$regex*"
    echo $regex
    grep -irE --include '*.py' $regex 
end
