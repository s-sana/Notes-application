# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get 'note_shares/:id/update_edit_request', to: 'note_shares#update_edit_request', as: :update_edit_request

  resources :notes do
    member do
      get 'shownote'
      get 'sharednote'
      get 'important'
    end

    collection do
      get 'tags/:tag', to: 'notes#tagged_notes', as: :tag
      get 'note_shares/request_edit', to: 'note_shares#request_edit', as: :request_edit
      get 'note_shares/index'
      get 'note_shares/shared_by_me'
      get 'note_shares/request_view', to: 'note_shares#request_view', as: :request_view

      patch 'auto_save'
      patch 'notes_shares/edit_permission'
      patch 'notes_shares/view_permission'
    end

    resources :note_shares, only: %i[new create edit update destroy]
    resources :comments
  end

  resources :charges, only: %i[new create] do
    get 'refund', as: :refund, on: :collection
  end
  
  resources :refunds, only: %i[new create edit update]

  root 'notes#index'
end
