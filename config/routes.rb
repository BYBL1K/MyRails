MyStore::Application.routes.draw do
  
  resources :items do
  	get :upvote, on: :member
  	get :expensive, on: :collection
  end 
  # делает наш контроллер RESTFUL'om

  get "admin/users_count" => "admin#users_count"

end
