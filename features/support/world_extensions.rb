module KnowsTheDomain
  def sniper
    @sniper ||= Sniper.new
  end
end

World(KnowsTheDomain)
