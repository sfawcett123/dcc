---
title: Ruby 
nav_order: 20
has_children: true
has_toc: false
layout: page
---

# Ruby on Rails 
{:.no_toc}
Ruby is a  dynamic, open source programming language, with a vast knowledge base and open source libraries. 
This combined with the [MVC](https://developer.mozilla.org/en-US/docs/Glossary/MVC) framework [Rails](https://rubyonrails.org) gives us a great starting point to deliver a simple web application.

### GEMs
Libraries in Ruby are called GEMS and can be handled with a tool called bundler and projects can be kept seperated using an environment tool called rbenv  

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Requirements

1. [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
1. [Install bundle](https://bundler.io/man/bundle-install.1.html)
1. [Install rails](https://guides.rubyonrails.org/v5.0/getting_started.html)
1. [Install rbenv](https://github.com/rbenv/rbenv)

## Configure Redis
Redis is used as a cache by sidekiq ( background jobs )  and can be installed using the command: ```brew install redis``` but you may encounter a problem which can be resolved using the redis-cli

```
$ redis-cli
> config set stop-writes-on-bgsave-error no
> quit
```

## Configure

### Ruby 
