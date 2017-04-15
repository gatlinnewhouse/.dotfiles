#/bin/bash
#-- Script to automatically convert all git remotes to HTTPS from SSH for gitlab repos
# Script will change all the git remotes.
# If you didn't intend to do that, run the other script in this repo.
# Original 1: https://gist.github.com/m14t/3056747
# Original 2: https://gist.github.com/chuckbjones/9dc6634fe52e56ba45ac
# Thanks to @m14t, @michaelsilver and @chuckbjones.

ssh_to_https(){
	REPO_URL=`git remote -v | grep -m1 "^$1" | sed -Ene's#.*(git@gitlab.com:[^[:space:]]*).*#\1#p'`
	if [ -z "$REPO_URL" ]; then
		echo "-- ERROR:  Could not identify Repo url."
		echo "   It is possible this repo is already using HTTPS instead of SSH."
		exit
	fi

	USER=`echo $REPO_URL | sed -Ene's#git@gitlab.com:([^/]*)/(.*).git#\1#p'`
	if [ -z "$USER" ]; then
		echo "-- ERROR:  Could not identify User."
		exit
	fi

	REPO=`echo $REPO_URL | sed -Ene's#git@gitlab.com:([^/]*)/(.*).git#\2#p'`
	if [ -z "$REPO" ]; then
		echo "-- ERROR:  Could not identify Repo."
		exit
	fi

	#NEW_URL="git@github.com:$USER/$REPO.git"
	NEW_URL="https://gitlab.com/$USER/$REPO.git"
	echo "Changing repo url from "
	echo "  '$REPO_URL'"
	echo "      to "
	echo "  '$NEW_URL'"
	echo ""

	CHANGE_CMD="git remote set-url $1 $NEW_URL"
	echo "$CHANGE_CMD"
	`$CHANGE_CMD`
}

for i in `git remote`; do
	ssh_to_https "$i";
done;

echo "Moved everything to HTTPS!"
