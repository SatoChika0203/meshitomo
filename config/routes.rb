Rails.application.routes.draw do
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  root to: 'homes#top'
  get '/users/information/edit' => 'users#edit', as: 'users_information_edit'
  resource :users, except: [:create, :edit] do
      collection do
        get 'confirm'
        patch 'withdraw'
      end
  end
  resources :recruitments, expect: [:new] do
      collection do
        post 'confirm'
        get 'complete'
        get 'history'
      end
  end
  resources :applications, except: [:new, :index, :edit, :update] do
      collection do
        post 'cancel'
        post 'confirm'
        get 'complete'
        get 'history'
      end
  end
  resources :chat_groups, only: [:index, :show, :create]
  resources :chats, only: [:create]
  resources :reviews, except: [:destroy, :edit, :update]
end

devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :users
  resources :recruitments
  resources :chat_groups, only: [:index, :show]
  resources :chats, only: [:destroy]
  resources :reviews
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
