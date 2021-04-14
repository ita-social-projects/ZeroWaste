ROOT_DIR=$(git rev-parse --show-toplevel)

ln -s -f $ROOT_DIR/git-hooks/pre-commit $ROOT_DIR/.git/hooks/pre-commit
