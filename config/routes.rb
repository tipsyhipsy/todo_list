Rails.application.routes.draw do
	root 'tasks#index'
	get '/login', to:'sessions#new'
	post '/login', to:'sessions#create'
	delete '/logout', to:'sessions#destroy'

	resources :tasks
	resources :users, except: %i[index]
	resources :labellings, only: %i[create destroy]

	namespace :admin do
		resources :users
		resources :labels
	end
end
