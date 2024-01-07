run_in_container() {
  echo $@;
  podman-compose exec web $@
}

cd /opt/mastodon
run_in_container tootctl media remove --days=7
run_in_container tootctl media remove --days=7 --remove-headers
run_in_container tootctl media remove --days=7 --prune-profiles
run_in_container tootctl statuses remove --days=14
run_in_container tootctl preview_cards remove --days=30
#run_in_container tootctl accounts prune
