require 'sidekiq'
require 'sidekiq/api'
require "yaml"

class CronTabWorker
  include Sidekiq::Worker

  def perform(*args)
    Sidekiq.redis do |conn|
      conn.del("job:#{jid}")
    end

    if args[0] == 'reinit_crontab' then
      self.class.initTab()
    else
      if $crontabs.key?(args[1]) then
        self.class.insert_job($crontabs[args[1]]['freq'], args[1])
      end
      args[1].constantize.exec();
    end
  end

  def self.initTab() 
    crontablist = YAML.load_file("#{$app_path}/configs/crontab.yaml")
    #start new
    crontablist.each do |key,value|
      if not $crontabs.key?(key) then
        require "#{$app_path}/#{value['require']}" 
        self.insert_job(value['freq'], key);
      end
    end

    $crontabs = crontablist
  end

  #frequence
  def self.insert_job(frequence, jobname)
    self.perform_in(frequence, frequence, jobname)
  end
end
