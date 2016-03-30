crontab = {
  "LookupWorker"=>{"freq"=>"20", "require"=>"workers/lookup.rb"},
  "SendEmailWorker"=>{"freq"=>"20", "require"=>"workers/sendemail.rb"},
}

require "yaml"
File.write("crontab.yaml", crontab.to_yaml)

require "yaml"
args = YAML.load_file("crontab.yaml")

puts args.inspect
