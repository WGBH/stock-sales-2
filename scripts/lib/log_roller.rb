require 'logger'

module LogRoller
  log_file_name = "log/ingest-#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.log"
  $LOG = Logger.new(log_file_name)
  $LOG.formatter = proc do |severity, datetime, _progname, msg|
    "#{severity} [#{datetime.strftime('%Y-%m-%d %H:%M:%S')}]: #{msg}\n"
  end
  puts "logging to #{log_file_name}"
end
