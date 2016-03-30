require 'sidekiq'
require './starter'

CronTabWorker.perform_async('reinit_crontab', 1);
