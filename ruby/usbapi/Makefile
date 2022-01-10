fix:
	rubocop -A

rubocop:
	rubocop

brakeman:
	brakeman -q

test:	rubocop brakeman

run:
	rails server

connect:
	sqlite3 db/development.sqlite3

background:
	redis-cli --scan --pattern users: * | xargs redis-cli del
	bundle exec sidekiq

curl:
        curl -X PATCH "http://localhost:3000/arduino/959313231323513171B1?role=sausage""
