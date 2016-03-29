require 'sidekiq'

class SendEmailWorker
  include Sidekiq::Worker
  
  def self.exec(*args)
    IO.popen(["php", $app_config['MANDRILL_SENDEMAIL_SCIPT'], :err=>[:child, :out]]) {|ls_io|
  ls_result_with_error = ls_io.read
}
  end

  def perform(*args)
    self.exec(*args)
  end
end
