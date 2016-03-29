How to run sidekiq without rails
1. structure
Your code should be managed like below:

|--sidekiq
      |--starter.rb #this file define redis configuration
      |--worker
           |---- workers ruby code files here
      |--job.rb  #call this file and you can feed job to sidekiq


run sidekiq:
sidekiq -r ./starter.rb

triger a job:
ruby job.rb

Then you will see job running
