require 'sidekiq'
require 'sidekiq/api'
require './starter'

#https://github.com/utgarda/sidekiq-status so we can use status
#https://github.com/mperham/sidekiq/wiki/FAQ

#https://github.com/mperham/sidekiq/wiki/Using-Redis

result = LookupWorker.perform_async('job', 1)
result = LookupWorker.perform_in(5, 'delay call yongcheng', 10)  
puts result.inspect

result = TestWorker.perform_async('job', 2) 
puts result.inspect

