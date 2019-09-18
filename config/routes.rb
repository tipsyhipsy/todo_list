Rails.application.routes.draw do
	root 'tasks#index'
	get '/login', to:'sessions#new'
	post '/login', to:'sessions#create'
	delete '/logout', to:'sessions#destroy'

	resources :tasks
	resources :users, except: %i[index]

	namespace :admin do
		resources :users
	end
end
