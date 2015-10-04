require 'sidekiq'

class LookupWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "JID #{jid} LookupWorker#perform fired with arguments #{args.map(&:inspect).join(', ')}"
    Sidekiq.redis do |conn|
      conn.set("job:#{jid}", "done!")
    end
  end
end
