platform=$(uname)

if [[ $platform == 'Darwin' ]]; then
	alias openx='find . -d 1 | grep xcodeproj | head -n 1 | xargs open --fresh --background'
fi

twitch() {
	if ! hash livestreamer 2>/dev/null; then
		echo "Installing livestreamer"
		sudo pip install livestreamer
	fi

    livestreamer twitch.tv/$1 source
}
