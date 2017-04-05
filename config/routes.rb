Rails.application.routes.draw do
  get '/app' => 'home#index'
  get '/users/sign_in', to: redirect('/')
  devise_for :users
  root 'home#index'
  namespace :api do
    namespace :v1 do


      # Users
      post '/sign_up' => "users#sign_up"
      post '/sign_in' => "users#sign_in"
      post '/forgot_password' => "users#forgot_password"
      put '/reset_the_password' => "users#reset_the_password"
      post '/invite_user' => "users#invite_user"
      put '/update_user' => "users#update_user"
      # Messages
      post '/create_message' => "messages#create_message"
      post '/destroy_message' => "messages#destroy_message"
      get '/messages' => "messages#messages"

      # conversations
      post '/create_conversation' => "conversations#create_conversation"
      post '/destroy_conversation' => "conversations#destroy_conversation"
      get '/conversations' => "conversations#conversations"

      # participations
      post '/create_participation' => "participations#create_participation"
      post '/destroy_participation' => "participations#destroy_participation"
      get '/participations' => "participations#participations"




    end
  end
end
