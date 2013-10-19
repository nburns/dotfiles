function new_repo
	set user (git config --get user.name)
	read -p 'echo Enter repo name:' repo_name
	echo "Creating \"github.com/$user/$repo_name\""
	curl -u "$user" https://api.github.com/user/repos -d "\"{\"name\":\"$name\"}\""
	git init .
	git remote add origin "https://github.com/$user/$repo_name.git"
end