#!/usr/bin/ruby

require "setup" # use "bundle install --standalone"
require "hukku"

Hukku::App.workdir = "./app" # set root directory

Rack::Handler::CGI.run Hukku::App
