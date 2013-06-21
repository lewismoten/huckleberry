require 'spec_helper'

describe ProfilesController do
  describe 'routing' do
    it 'routes to #index' do
      get('/profiles').should route_to('profiles#index')
    end
    it 'routes to #show' do
      user = users(:admin)
      get("/profiles/#{user.initials}").should route_to('profiles#show', initials: user.initials)
    end

    it 'routes to #approve' do
      user = users(:admin)
      post("/profiles/#{user.initials}/approve").should route_to('profiles#approve', initials: user.initials)
    end
  end
end
