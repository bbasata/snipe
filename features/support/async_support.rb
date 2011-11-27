# via The Cucumber Book

module HasAsyncSupport
  def eventually
    timeout = 2
    polling_interval = 0.1
    time_limit = Time.now + timeout
    loop do
      begin
        yield
      rescue => error
      end
      return if error.nil?
      raise error if Time.now >= time_limit
      sleep polling_interval
    end
  end
end

World(HasAsyncSupport)
