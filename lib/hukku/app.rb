# coding: utf-8
require "sinatra/base"
require "sinatra/config_file"
require "json/pure"

module Hukku
  class App < Sinatra::Base

    register Sinatra::ConfigFile
    F = File

    config_file "config.yml"
    config_file "repo.yml"

    set :app_dir, F.expand_path(F.join(F.dirname(__FILE__),"..","..","app"))

    def self.load_settings
    end

    def self.work_dir=(value)
      set :root, value
      load_settings
    end

    configure :development do
      set :root, app_dir
      load_settings
    end

    post "/sfjp" do
      webhook = JSON.parse params["payload"]
      "i've received webhook!"
    end
  end
end
