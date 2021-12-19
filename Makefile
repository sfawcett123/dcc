install_jekyll:
	gem install bundler
	bundle install

run_jekyll: install_jekyll
	bundle exec jekyll serve
