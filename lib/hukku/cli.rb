# coding: utf-8
require "thor"

module Hukku
  class CLI < Thor

    include Thor::Actions

    desc "start","Sinatra アプリケーションを開始します。"
    method_option :port,        :type => :numeric, :aliases => "-p"
    method_option :bind,        :type => :string,  :aliases => "-b"
    method_option :environment, :type => :string,  :aliases => "-e"
    def start
      opts = {}
      options.each{|k,v| opts[k.to_sym] = v }

      ENV["RACK_ENV"] = opts[:environment]

      opts[:bind] ||= "0.0.0.0"

      require 'hukku/app'
      Hukku::App.run!(opts)
    end
  end
end
