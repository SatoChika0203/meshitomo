Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

namespace :admin do
    resources :users
    resources :recruitments
    resources :chat_groups, only: [:index, :show]
    resources :chats, only: [:destroy]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
