fix:
	rubocop -A

rubocop:
	rubocop

brakeman:
	brakeman -q

test:	rubocop brakeman

run:	assets
	rails server

assets:
	rails assets:clean
	rails assets:precompile

rebuild:
	bundle install
	rails db:drop
	rails db:create
	rails db:schema:load
	rails db:seed

connect:
	sqlite3 db/development.sqlite3

background:
	redis-cli --scan --pattern users: * | xargs redis-cli del
	bundle exec sidekiq

erd:
	bundle exec erd	
