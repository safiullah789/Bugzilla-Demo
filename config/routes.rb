Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :projects do
  	member do
  		patch 'add_member'
  		delete 'remove_member/:user_id' => 'projects#remove_member', as: :remove
  		end
  	resources :bugs
  	end
  	
 resources :welcome
  root 'welcome#index'


end
