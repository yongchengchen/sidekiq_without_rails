require 'sidekiq'

#config redis
Sidekiq.configure_server do |config|
  #check every 15sec
  #config.average_scheduled_poll_interval = 15
  config.redis = { url: "redis://127.0.0.1:6379/1" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://127.0.0.1:6379/1"}
end

workers_path = File.dirname(__FILE__)
workers =  Dir["#{workers_path}/workers/*.rb"]
workers.each {|worker| require "#{worker}"}
