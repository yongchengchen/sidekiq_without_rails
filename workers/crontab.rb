require 'sidekiq'

class CronTabWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "JID #{jid} LookupWorker#perform fired with arguments #{args.map(&:inspect).join(', ')}"
    Sidekiq.redis do |conn|
      conn.del("job:#{jid}")
    end
  
    #self.class.perform_in(args[0], args[0], args[1])
    self.class.insert_job(args[0], args[1])
    args[1].constantize.exec();
  end

  def self.initTab() 
    #self.perform_in(20, 20, 'SendEmailWorker');
    self.insert_job(5, 'SendEmailWorker');
  end

  #frequence
  def self.insert_job(frequence, jobname)
    self.perform_in(frequence, frequence, jobname)
  end
end
