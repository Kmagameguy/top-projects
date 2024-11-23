# Odin API Introduction

This project is a simple Ruby on Rails application which allows you to manage
kittens and their name, age, cuteness, and softness attributes.  It is intended
to introduce API development with Rails.  While the site is viewable in browser,
the KittensController includes some extra logic which allows a user to query the
system from a commandline for Kitten data.

## Setup

1. Clone this repo
1. `cd` into the project folder
1. Run `bundle install`
1. Run `bin/rails db:migrate`
1. Run `bin/rails server`
1. Visit `localhost:3000` in your browser

## Browser Views

### View all Kittens
Visit `localhost:3000/kittens` to view all kittens.

### View a Single Kitten
Visit `localhost:3000/kittens/:id` to view a kitten, or select a kitten from the
home page.

### Create a Kitten
Visit `localhost:3000/kittens/new` to create a new kitten.  Fill out the form.

### Edit a Kitten
Visit `localhost:3000/kittens/:id/edit` to edit a kitten, or select a kitten from the
home page.  Fill out the form.

### Delete a Kitten
Visit `localhost:3000/kittens/:id` and click the delete button.

## Interaction with the "API"

Use something like the `rest-client` gem to interact with the API.  From irb:
1. `require 'rest-client'`
1. `response = RestClient.get('http://localhost:3000/kittens', accept: :json)`

To view a single kitten just supply the kitten ID in the URL:
1. `response = RestClient.get('http://localhost:3000/kittens/1', accept: :json)`
