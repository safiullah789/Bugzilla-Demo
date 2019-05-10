Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :projects do
  	member do
  		patch 'add_member'
  		delete 'remove_member/:user_id' => 'projects#remove_member', as: :remove
  	end
  	resources :bugs do
      member do
         get 'assign', to: 'bugs#assign'
    end
  end
  end

  get 'edit_status', to: 'bugs#edit_status'



  root 'projects#index'


end
