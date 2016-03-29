config = {
  "REDIS"=>"redis://127.0.0.1:6379/1",
  "POLL_INTERVAL"=>"5",
  "MANDRILL_SENDEMAIL_SCIPT"=>"/home/tonercity/git/aws_front/shell/MandrillProcessor.php",
}

require "yaml"
File.write("config.yaml", config.to_yaml)

require "yaml"
args = YAML.load_file("config.yaml")

puts args.inspect
