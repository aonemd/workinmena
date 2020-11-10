# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch('PORT') { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RAILS_ENV') { 'development' }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

root     = File.expand_path('..', __dir__)
puma_dir = "#{root}/puma"

# logs
stdout_redirect "#{puma_dir}/logs/puma.stdout.log", "#{puma_dir}/logs/puma.stderr.log", true

# master PID and state
pidfile "#{puma_dir}/pids/puma.pid"
state_path "#{puma_dir}/pids/puma.state"
activate_control_app

# socket
bind "unix://#{puma_dir}/sockets/puma.sock"
# bind 'ssl://127.0.0.1:3000?key=/etc/letsencrypt/live/workinmena.tech/privkey.pem&cert=/etc/letsencrypt/live/workinmena.tech/fullchain.pem'
ssl_bind '127.0.0.1', '3002', {
  key: '/etc/letsencrypt/live/workinmena.tech/privkey.pem',
  cert: 'cert=/etc/letsencrypt/live/workinmena.tech/fullchain.pem'
}

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
