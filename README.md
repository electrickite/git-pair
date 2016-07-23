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

### SSH Keys

git-pair can optionally switch SSH keys when paring. To enable this feature, you
will need to add a stanza to `~/.ssh/config` for each remote git host:

    Host git-server.example.com
      IdentityFile    ~/.ssh/pair_id
      IdentitiesOnly  yes

Then add the following to your `.pairs` file:

    PAIR_KEY_FILE="/home/myuser/.ssh/pair_id"
    PAIR_KEY_DEFAULT="/home/myuser/.ssh/id_rsa" #If a default SSH key exists

And finally the SSH key file for each user is set with:

    PAIR_USER_U1_KEY="/home/myuser/.ssh/user1_id"

Only a private key is necessary for each user, but git-pair will also make use
of the public key if it shares the same file name with a `.pub` extension.

**NOTE:** The file specified in `PAIR_KEY_FILE` as well as its corresponding
`.pub` public key will be deleted and replaced by a symlink during the `pair`
command. Be sure there is no file at that path!

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

Acknowledgements
----------------

  * Created by: [Corey Hinshaw](1)
  * Inspired by: [Henrik Nyh](2)

License
-------

Released into the public domain.  See the [LICENSE](1) file for further details.


[1]: https://github.com/electrickite
[2]: https://github.com/henrik
[3]: https://github.com/electrickite/git-pair/blob/master/LICENSE
