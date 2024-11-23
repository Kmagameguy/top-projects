# The Odin Project - Intro to APIs

## Introduction

This is a photo-stream app built with Ruby on Rails.  It interfaces with the Flickr API to display public photos from a user's photostream.  It is a project
from [The Odin Project](https://www.theodinproject.com/lessons/ruby-on-rails-flickr-api).  The purpose of this project is to get familiar with
external resources and API calls.

## Set Up
1. Clone this repo
1. Sign up for a [Flickr](https://www.flickr.com/) account (or sign-in)
1. Go to [Flickr's App Garden](https://www.flickr.com/services/apps/create/apply/) and apply for a non-commercial API key
1. Make a copy of the included `.env` and name it `.env.local`
1. Replace the `ENV['FLICKR_API_KEY']` value with your API key
1. Replace the `ENV['FLICKR_SHARED_SECRET']` value with your shared secret
1. Run `bundle install`
1. Run `rails server` to start the server
1. Navigate to `localhost:3000` in your browser to see the application
