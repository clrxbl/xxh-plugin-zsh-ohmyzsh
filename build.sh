#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir

for f in pluginrc.zsh
do
    cp $CDIR/$f $build_dir/
done

cd $build_dir

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

ohmyzsh_home=$build_dir/ohmyzsh
if [ -x "$(command -v git)" ]; then
  git clone $arg_q --depth 1 https://github.com/robbyrussell/oh-my-zsh.git $ohmyzsh_home
  git clone $arg_q https://github.com/zsh-users/zsh-history-substring-search $ohmyzsh_home/plugins/zsh-history-substring-search
  git clone $arg_q https://github.com/zsh-users/zsh-autosuggestions $ohmyzsh_home/plugins/zsh-autosuggestions
  git clone $arg_q https://github.com/zsh-users/zsh-syntax-highlighting.git $ohmyzsh_home/plugins/zsh-syntax-highlighting
  rm -rf $ohmyzsh_home/themes
  git clone $arg_q https://github.com/denysdovhan/spaceship-prompt.git $ohmyzsh_home/themes
else
  echo Install git
  exit 1
fi
