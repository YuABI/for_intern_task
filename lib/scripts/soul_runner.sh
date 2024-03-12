#!/usr/bin/env bash
#
# /home/admin/egg_cart_develop_soul/lib/scripts/soul_runner.sh 'p "#{Time.now}: #{rand(123)}"' production
#
TARGET_RVM="/usr/local/rvm/gems/ruby-3.0.5/environment"
TARGET_ACTION=$1 # exec action : 'p "#{Time.now}: #{rand(123)}"'
TARGET_ENV=$2    # rails env : production
if
  [[ -s $TARGET_RVM ]]
then
  cd $(dirname $0)
  cd ../../
  source $TARGET_RVM
  exec bin/rails r "$TARGET_ACTION" -e $TARGET_ENV
else
  echo "ERROR: Missing RVM environment file: '$TARGET_RVM'" >&2
  exit 1
fi