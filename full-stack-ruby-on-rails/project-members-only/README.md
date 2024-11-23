# Members Only!

This application is a completed version of
The Odin Project's ["Members Only!"][members-only] Ruby on Rails assignment.  
  
The app is a basic messaging service.  Users can self-register and create posts.
- Unregistered (or logged out) users can see post history, but they cannot see post authors.
- Logged-in users are able to see post authors.
  
The application leans on the [Devise][devise] gem for most of the heavy lifting,
including registration, log-in, and log-out, with validations for each.
# Setting Up
1. `git clone git@github.com:Kaktug/top-projects.git`
1. `cd top-projects/full-stack-ruby-on-rails/project-members-only`
1. `bundle install`
1. `bin/rails db:prepare`
1. `bin/rails server`
1. Navigate to `localhost:3000` in a browser

[members-only]:https://www.theodinproject.com/lessons/ruby-on-rails-members-only
[devise]:https://github.com/heartcombo/devise
