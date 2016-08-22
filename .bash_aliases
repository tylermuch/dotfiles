alias openx='find . -d 1 | grep xcodeproj | head -n 1 | xargs open --fresh --background'

alias pull='find "$(pwd)" -type d -depth 1 | xargs -I {} bash -c "if git -C {} rev-parse ; then echo \"Pulling {}\" ; git -C {} pull --rebase &> /dev/null ; fi"'

twitch() {
    livestreamer twitch.tv/$1 source
}
