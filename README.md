Git Pair
========

Bash scripts to facilitate git commits while pair programming.

Installation
------------

Add the following to the `~/.bashrc` file:

    source /path/to/git-pair/git-pair.sh

Configuration
-------------

git-pair reads in configuration variables from a `.pairs` file in either the
current directory or the user home directory. The `.pairs` file is a simple
list of shell variables with the following format:

    PAIR_USER_U1_NAME="User 1"
    PAIR_USER_U1_EMAIL="user1@example.com"
    PAIR_USER_U2_NAME="User 2"
    PAIR_USER_U2_EMAIL="user2@example.com"

Where "U1" and "U2" are user identifiers to be used in the pairing commands.

git-pair can optionally manage SSH keys. To enable this feature, you will need
to add a stanza to `~/.ssh/config` for your git remote:

    Host git-server.example.com
      IdentityFile    ~/.ssh/pair_id
      IdentitiesOnly  yes

Then add the following to your `.pairs` file:

    PAIR_KEY_FILE="/home/myuser/.ssh/pair_id"
    PAIR_KEY_DEFAULT="/home/myuser/.ssh/id_rsa" #If a default SSH key exists

And finally the SSH key file for each user is set with:

    PAIR_USER_U1_KEY="/home/myuser/.ssh/user1_id"

Use
---

Check pairing status:

    $ pair

Start pairing with users identified by "U1" and "U2" in the `.pairs` file:

    $ pair U1 U2

This will set the commit author name to "User 1 and User 2" and the author email
to "user1@example.com"

Disable pairing with:

    $ unpair

Amend the last commit with the current pair (when you forget to set the pair
before committing.)

    $ pair!
