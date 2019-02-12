Rails.application.routes.draw do

#get 'notes/search'

  resources :notes do
get 'shownote'

    resources :comments
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "notes#index"
end
