fix:
	rubocop -A

rubocop:
	rubocop

brakeman:
	brakeman -q

test:	rubocop brakeman

server:
	rails assets:precompile
	rails server

run:
    rails assets:precompile
	foreman start	

clean:
	git clean -fdx

rebuild:
	bundle install
	rails db:drop
	rails db:create
	rails db:schema:load
	rails db:seed

connect:
	sqlite3 db/development.sqlite3

erd:
	bundle exec erd	
