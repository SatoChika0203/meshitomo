Rails.application.routes.draw do
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  root to: 'homes#top'
  resources :users, except: [:new, :index, :create, :destroy] do
      member do
        get 'confirm'
        patch 'withdraw'
      end
      resources :user_shops, only: [:index]
  end

  resources :recruitments do
      member do
        post 'confirm'
        post 'generate'
        get 'complete'
        patch 'withdraw'
      end
      collection do
        get 'history'  #URLにid含めなくても、currentでログインユーザーの情報を表示させる
        get 'search'
      end
      resource :applications, except: [:new, :index, :edit, :update, :destroy] do
        collection do
          post 'cancel'
          post 'confirm'
          get 'complete'
          patch 'withdraw'
          # get 'history'
        end
      end
      resource :chat_groups, only: [:show]
  end

  resource :applications, except: [:new, :create, :index, :edit, :update, :destroy] do
    collection do
      get 'history'
    end
  end

  resources :chat_groups, only: [:index]
  resources :chats, only: [:create]
  resources :reviews, except: [:destroy, :edit, :update]
  resources :shops do
    collection do
      get 'search'
    end
    resource :user_shops, only: [:create, :destroy]
  end
end

# __________________________

devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :users do
      member do
        patch 'withdraw'
      end
      resources :user_shops, only: [:index]
      resources :chat_groups, only: [:index]
      resource :recruitments, except: [:new, :create, :index, :show, :edit, :update, :destroy] do
        collection do
          get 'history'  
        end 
      end
      resource :applications, except: [:new, :create, :index, :show, :edit, :update, :destroy] do
        collection do
          get 'history'
        end
      end
  end
  
  resources :recruitments do
      resource :chat_groups, only: [:show]
  end
  
  resources :chat_groups, only: [:index]
  
  resources :chats, only: [:destroy]
  
  resources :reviews
  
  resource :applications, except: [:new, :create, :index, :edit, :update, :destroy] do
    collection do
      get 'history'
    end
    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

end

end