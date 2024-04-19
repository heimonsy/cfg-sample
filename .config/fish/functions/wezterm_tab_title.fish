function wezterm_tab_title
	echo "\x1b]1337;SetUserVar=panetitle=(echo -n $argv[1] | base64)\x07"
end
