# Simple git pair.

getpair() { echo "`git config user.name` <`git config user.email`>"; }

pair() {
  if [ -z "$1" ]; then
    echo Committing as: `getpair`
  else
    setpair "$1" "$2"
  fi
}

alias unpair="git config --remove-section user 2> /dev/null; resetpairkey; echo Unpaired.; pair"

# Amend the last commit with the current pair (when you forget to set the pair until after committing.)
alias pair!='git commit --amend -C HEAD --author="`getpair`"; git show --format="Author: %an <%ae>" --quiet'

setpair() {
  if [ -z "$1" ]; then
    echo "No user identifiers specified."
    return 1
  fi

  setpairconfig

  user1_name_var="PAIR_USER_$1_NAME"
  user1_email_var="PAIR_USER_$1_EMAIL"
  pair="$1"
  email="${!user1_email_var}"
  name="${!user1_name_var}"

  if [ ! -z "$2" ]; then
    user2_name_var="PAIR_USER_$2_NAME"
    user2_email_var="PAIR_USER_$2_EMAIL"
    pair="$pair+$2"
    name="$name and ${!user2_name_var}"
  fi

  git config user.pair "$pair" \
  && git config user.email "$email" \
  && git config user.name "$name"

  setpairkey $1

  pair
}

setpairkey() {
  setpairconfig
  if [ ! -z "$PAIR_KEY_FILE" ]; then
    rm -f "$PAIR_KEY_FILE"
    rm -f "$PAIR_KEY_FILE.pub"

    if [ ! -z "$1" ]; then
      user_key_var="PAIR_USER_$1_KEY"
      key="${!user1_key_var}"
    else
      key="$PAIR_KEY_DEFAULT"
    fi

    if [ -f "$key" ]; then
      ln -s "$key" "$PAIR_KEY_FILE"
      if [ -f "$key.pub" ]; then
        ln -s "$key.pub" "$PAIR_KEY_FILE.pub"
      fi
    fi
  fi
}

alias resetpairkey='setpairkey'

setpairconfig() {
  local_config=".pairs"
  home_config="$HOME/.pairs"

  if [ -f "$local_config" ] && [ -r "$local_config" ]; then
    source "$local_config"
  elif [ -f "$home_config" ] && [ -r "$home_config" ]; then
    source "$home_config"
  fi
}
