require 'socket'
require 'open3'

task :default => :boot

desc 'Boots the mock server'
task :boot do

  host = Socket.ip_address_list.find { |a| a.ipv4? && !a.ipv4_loopback? }.ip_address
  port = 9292

  pid = Boot.execute(host, port)

  while true
    sleep 0.1
    # http://en.wikipedia.org/wiki/Unix_signal
    Signal.trap('INT') do
      puts "About to kill process #{pid}"
      `kill -9 #{pid}`
      exit
    end
  end
end

# Boots up the mock server by spawning a new thread,
# calling rack up and outputing stdout and stderr
class Boot

  def self.execute(host, port)

    puts "About to boot mock server http://#{host}:#{port}"
    puts "CTRL + C to exit"

    command = "rackup config.ru -o #{host} -p #{port}"

    stdin, stdout, stderr, wait_thr = Open3.popen3(command)
    [stdout, stderr].each do |stream|

      Thread.new do
        until (line = stream.gets).nil? do
          puts line
        end
      end
    end

    wait_thr[:pid]
  end
end
