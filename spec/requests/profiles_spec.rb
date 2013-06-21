require 'spec_helper'
include Warden::Test::Helpers

describe 'Profiles' do
  describe 'GET /profiles' do
    describe 'unauthenticated' do
      it 'unauthenticated redirects to new user session' do
        get users_path
        response.should redirect_to(new_user_session_url)
      end
    end
    describe 'approved' do
      it 'shows profiles' do
        login_as users(:approved)
        get users_path
        response.should be_ok
      end
      after do
        Warden.test_reset!
      end
    end
    describe 'admin' do
      it 'shows messages' do
        login_as users(:admin)
        get users_path
        response.should be_ok
      end
      after do
        Warden.test_reset!
      end
    end
    describe 'pending approval' do
      it 'redirects to new user session' do
        login_as users(:unapproved)
        get users_path
        response.should redirect_to(new_user_session_url)
      end
      after do
        Warden.test_reset!
      end
    end
  end

  describe 'POST /profiles/:initials/approve' do
    describe 'unauthenticated' do
      it 'unauthenticated redirects to new user session' do
        post approve_user_path(:unapproved)
        response.should redirect_to(new_user_session_url)
      end
    end
    describe "non-admin" do
      it 'shows profiles' do
        login_as users(:approved)
        post approve_user_path(:unapproved)
        response.should redirect_to(users_path)
      end
      after do
        Warden.test_reset!
      end
    end
    describe 'admin' do
      it 'shows messages' do
        login_as users(:admin)
        post approve_user_path(users(:unapproved))
        response.should redirect_to(users_path)
      end
      after do
        Warden.test_reset!
      end
    end
    describe 'pending approval' do
      it 'redirects to new user session' do
        login_as users(:unapproved)
        post approve_user_path(:unapproved)
        response.should redirect_to(new_user_session_url)
      end
      after do
        Warden.test_reset!
      end
    end
  end
end
