Rails.application.routes.draw do

  root "homes#top"
  get "/about" => "homes#about"

  devise_for :end_users, controllers: {
    sessions: "end_users/sessions",
    registrations: "end_users/registrations"
  }
  namespace :end_users do
    get "search_ways" => "search_ways#search_ways"
    get "searches/recipe_search" => "searches#recipe_search"
    get "searches/ingredient_search" => "searches#ingredient_search"
    resources :nutrients, only: [:index]
    resources :ingredients, only: [:index, :new, :create, :show]
    resources :juicer_ingredients, only: [:create, :index, :destroy, :update] do
      delete :destroy_all, on: :collection
    end
    resources :end_users, only: [:show, :index, :destroy] do
      get :destroy_confirm, on: :collection
      patch :is_deleted_update, on: :member
      get :favorite_list, on: :member
      get :recipe_list, on: :member
    end
    resources :smoothies, only: [:new, :create, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only:[:new, :create, :destroy]
      patch :is_recommended_update, on: :member
      get :new_smoothies, on: :collection
      get :smoothie_ranking, on: :collection
    end
  end

  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }

  namespace :admins do
    resources :comments, only: [:index, :destroy]
    resources :end_users, only: [:index, :update]
    resources :ingredients, only: [:create, :show, :update, :destroy, :index, :new]
    resources :smoothies, only: [:index, :show, :destroy]
     resources :nutrients, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
