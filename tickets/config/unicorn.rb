# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/vagrant/tickets"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/vagrant/tickets/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/vagrant/tickets/log/unicorn.log"
stdout_path "/vagrant/tickets/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.tickets.sock"


# Time-out
timeout 30

# Number of processes
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    msg  = 'Unicorn worker intercepting TERM and doing nothing. '
    msg += 'Wait for master to send QUIT'
    puts msg
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

