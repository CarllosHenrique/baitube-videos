Rails.application.routes.draw do
  devise_for :channels, controllers: {
    registrations: 'channels/registrations'
  }
  scope '/channel' do
    get 'me', to: 'channel#profile', as: 'my_channel'
    patch 'me', to: 'channel#update', as: 'my_channel_update'
    get 'me/edit', to: 'channel#edit', as: 'my_channel_edit'
    get '/:id', to: 'channel#channel', as: 'user_channel'
  end

  root 'home#index'

  resources :videos
end
