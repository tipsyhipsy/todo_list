Rails.application.routes.draw do
root 'tasks#index'
resources :tasks
resources :users, except: %i[index]
resources :sessions, only: %i[new create destory]
end
