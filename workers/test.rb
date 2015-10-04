require 'sidekiq'

class TestWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "TEST--- Workder#perform fired with arguments #{args.map(&:inspect).join(', ')}"
  end
end
