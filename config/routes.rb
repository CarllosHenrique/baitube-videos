Rails.application.routes.draw do
  devise_for :channels, controllers: {
    registrations: 'channels/registrations'
  }
  scope '/channel' do
    get 'me', to: 'channel#profile', as: 'my_channel'
    patch 'me', to: 'channel#update', as: 'my_channel_update'
    get 'me/edit', to: 'channel#edit', as: 'my_channel_edit'
    get '/:id', to: 'channel#channel', as: 'user_channel'
    post '/:id', to: 'channel#subscribe_channel', as: 'subscribe_channel'
    delete '/:id', to: 'channel#unsubscribe_channel', as: 'unsubscribe_channel'
  end

  root 'home#index'

  resources :videos do
    resources :comments, only: [:create]
    member do
      patch 'like', to: 'videos#like', as: 'create_like'
      patch 'deslike', to: 'videos#deslike', as: 'create_deslike'
      post 'denounce', to: 'videos#denounce', as: 'send_denounce'
    end
  end
end
