require 'spec_helper'

describe 'profiles/index' do

  before(:each) do
    @profile_user_1 = stub_model(User, name: 'John Smith', initials: 'JS', approved: true)
    @profile_user_2 = stub_model(User, name: 'Jane Doe', initials: 'JD', approved: false)
    assign(:profile_users, [@profile_user_1, @profile_user_2])

    assign(:channels, [stub_model(Channel, name: 'Name')])
    assign(:users, [stub_model(User, name: 'Name')])
    assign(:message, stub_model(Message, text: '', errors: []))
    assign(:current_user, stub_model(User, is_admin: true))
  end

  it 'renders a list of users' do
    controller.stub(:current_user).and_return stub_model(User, is_admin?: true)
    render
    assert_select 'tr:nth-of-type(1)>td:nth-of-type(2)', text: @profile_user_1.name, count: 1
  end

  it 'renders approve user links for admin' do
    controller.stub(:current_user).and_return stub_model(User, is_admin?: true)
    render
    assert_select 'tr:nth-of-type(2)>td:nth-of-type(4)', text: 'Approve', count: 1
  end

  it 'renders without approve user links for non-admin' do
    controller.stub(:current_user).and_return stub_model(User, is_admin?: false)
    render
    assert_select 'tr:nth-of-type(2)>td:nth-of-type(4)', text: 'Approve', count: 0
  end

  it 'renders approved users without approve user links for admin' do
    controller.stub(:current_user).and_return stub_model(User, is_admin?: true)
    render
    assert_select 'tr:nth-of-type(1)>td:nth-of-type(4)', text: 'Approve', count: 0
  end

  def current_user
    return stub_model(User, is_admin: true)
  end
end
