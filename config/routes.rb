Rails.application.routes.draw do
  devise_for :users
  resources :foods
  post 'recipes/:id/toggle', to: 'recipes#toggle', as: :toggle_recipe 
  get 'general_shopping_list', to: 'users#shopping_list'
  resources :users do
    resources :recipes do
      resources :recipe_foods, only: [:new, :create, :destroy, :update, :edit]
    end
  end
  root "recipes#public"
end
