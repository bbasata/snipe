module KnowsTheWebInterface
  class WebSnipe
    include Capybara::DSL

    def start_bidding_in(item_id)
      visit '/'
      click_button 'Start Bidding'
    end

    def status
      visit '/'
      find('#auction-status').text
    end
  end

  def sniper
    @sniper ||= WebSnipe.new
  end
end

World(KnowsTheWebInterface)
