# coding: utf-8
require "sinatra/base"
require "sinatra/config_file"
require "json/pure"
require "systemu"
require "logger"
require "fileutils"

module Hukku
  class App < Sinatra::Base

    register Sinatra::ConfigFile
    F = File

    set :app_dir, F.expand_path(F.join(F.dirname(__FILE__),"..","..","app"))
    set :gem_dir, F.expand_path(F.join(F.dirname(__FILE__),"..",".."))

    def self.load_settings
      config_file "config.yml"
      config_file "repo.yml"
      unless settings.test?
        FileUtils.mkdir_p File.join(root,"log")
        logfile = File.join(root,'log/hukku.log')
        FileUtils.touch logfile
        set :logger, Logger.new(logfile, 'monthly')
      end
    end

    def self.work_dir=(value)
      set :root, value
      load_settings
    end

    configure :development,:test do
      set :root, app_dir
      load_settings
    end


    get "/" do
      "<html></html>"
    end

    post "/sfjp" do
      halt 500 unless params["payload"]
      settings.logger.info "request has payload"

      webhook = JSON.parse params["payload"]
      halt 500 unless webhook["repository"] && webhook["repository"]["name"]
      settings.logger.info "request is valid webhook"

      repo_name = webhook["repository"]["name"]
      halt 500 unless settings.repo[repo_name]
      settings.logger.info "repository name is registered in config file"

      cmd = "#{F.join(settings.gem_dir,settings.mirror_cmd)} #{settings.repo[repo_name]}"
      status, stdout, stderr = systemu cmd

      halt 500 unless status.success?
      settings.logger.info "command execution is successfull"

      "i've received webhook!"
    end
  end
end
