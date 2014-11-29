OtherSide::Application.routes.draw do

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
    
      resources :users
      post 'login', :to => 'sessions#create'

    end
  end

end