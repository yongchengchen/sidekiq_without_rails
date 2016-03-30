require 'sidekiq'
require 'sidekiq/api'
require "yaml"

$app_path = File.dirname(__FILE__)
#require "#{workers_path}/config.rb"

$app_config = YAML.load_file("configs/config.yaml")
#config redis
Sidekiq.configure_server do |config|
  #check every 15sec
  #Sidekiq::Scheduled.const_set("POLL_INTERVAL", $app_config['POLL_INTERVAL'].to_f)
  config.poll_interval = $app_config['POLL_INTERVAL'].to_f
  config.redis = { url: $app_config['REDIS'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: $app_config['REDIS']}
end

queue = Sidekiq::ScheduledSet.new
queue.each do |job|
  if job.klass == 'CronTabWorker' then
    job.delete
  end
end

workers =  Dir["#{$app_path}/workers/*.rb"]
workers.each {|worker| require "#{worker}"}

$crontabs = {}
CronTabWorker.initTab();
