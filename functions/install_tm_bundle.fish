function install_tm_bundle
	set git_repository $argv[1]
	set desired_name $argv[2]
	git clone $git_repository '$HOME/Library/Application Support/TextMate/Managed/Bundles/$desired_name'
end
