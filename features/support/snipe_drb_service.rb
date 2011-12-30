Process.spawn('bundle exec ruby -I lib bin/serve_snipe.rb').tap do |pid|
  sleep 5 # wait for service to spawn
  at_exit do
    Process.kill("HUP", pid)
  end
end
