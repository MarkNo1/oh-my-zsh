: '
------------------------------------------------------------------------------
         FILE:  net-alias
  DESCRIPTION:  oh-my-zsh plugin.
       AUTHOR:  marco treglia (marco.treglia@akka.eu)
      VERSION:  1.0.0
------------------------------------------------------------------------------
'

function Login() {
  echo -e "Login into ${1}"
  xhost +
  ssh -2 -XY ${1}
}

SetConnection() {
  NAME=$(echo "$1" | tr '[a-z]' '[A-Z]')
  if [[ $NETMASK ]]; then
    address="$3@${NETMASK}.$2"
    alias "$1"="Login ${address}"
    export "${NAME}_ADDR"=$address
    echo -e "Fast connection to \e[1;28m$1\e[0m : $address  "
  else
    echo -e "No env NETMASK is setted"
  fi
}

function Copy() {
  echo -e "Copying from ${1}  to  ${2}"
  rsync -av --progress -e ssh ${1} ${2}
}


LoadConfiguration(){
  cfg=".net-alias.cfg"
  if [ -f  "$HOME/$cfg" ]; then
    source "$HOME/$cfg"
    echo "[net-alias] $emoji[winking_face]"
  else
    echo "[net-alias]: No $cfg in $HOME. $emoji[dizzy_face]"
  fi
}

LoadConfiguration
