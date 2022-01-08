fix:
	rubocop -A

rubocop:
	rubocop

brakeman:
	brakeman -q

test:	rubocop brakeman

run:
	rails server


background:
	redis-cli --scan --pattern users: * | xargs redis-cli del
	bundle exec sidekiq
