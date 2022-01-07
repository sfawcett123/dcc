fix:
	rubocop -A

rubocop:
	rubocop

rspec:
	bundle exec rspec

brakeman:
	brakeman -q

test:	rubocop rspec brakeman

run:
	rails server


background:
	bundle exec sidekiq
