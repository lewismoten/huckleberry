Huckleberry::Application.routes.draw do
  devise_for :users

  root to: 'messages#index'

  resources :messages, only: [:show, :index, :create, :new ]

  controller :profiles do
    match 'profiles' => :index, as: :users, via: :get
    match 'profiles/:initials' => :show, as: :user, via: :get
    match 'profiles/:initials/approve' => :approve, as: :approve_user, via: :post
  end

  controller :channels do
    match 'channels/:name' => :show, as: :channel, via: :get
  end
end
