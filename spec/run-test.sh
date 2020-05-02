#!/bin/bash
set -e

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

cd "${DIR}/.."

rubocop(){
    echo "Run Rubocop"
    bundle exec rubocop libraries spec ./doc/*.rb test/examples/opsman/controls/*.rb
}
rspec(){
    echo "Run rspec"
    bundle exec rspec --format d 
}

case ${1} in
rubocop)
    rubocop
  ;;
rspec)
    rspec
  ;;
*)
    rubocop
    rspec
  ;;
esac