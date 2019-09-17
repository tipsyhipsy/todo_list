Rails.application.routes.draw do
root 'tasks#index'
resources :tasks
resources :users, except: %i[index]
get '/login', to:'sessions#new'
post '/login', to:'sessions#create'
delete '/logout', to:'sessions#destroy'
end
