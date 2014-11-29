OtherSide::Application.routes.draw do

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      
      post 'signup', :to => 'users#create'
      post 'login', :to => 'sessions#create'
      resources :users
   
    end
  end

end