Rails.application.routes.draw do
  resources :users do
    resources :contacts
  end
  resources :sessions
  resources :groups
  match '/login',    to: 'sessions#new',         via: 'get'
  match '/',         to: 'sessions#index',       via: 'get'
  match '/signout',  to: 'sessions#destroy',     via: 'delete'
  match '/delete_account', to: 'users#delete_account', via: 'get'
  match '/delete_confirmed', to: 'users#delete_confirmed', via: 'post'
  match '/delete_group',  to: 'contacts#delete_group',  via: 'get'
  match '/remove_group_member', to: 'contacts#remove_group_member', via: 'get'
  match '/change_password', to: 'users#change_password_form', via: 'get'
  match '/change_password_confirm', to: 'users#change_password', via: 'patch'
  match '/add_group_member', to: 'contacts#add_group_member_list_show', via: 'get'
  match '/add_member_process', to: 'contacts#add_group_member', via: 'get'
  match '/add_group', to: 'groups#add_group', via: 'get'
  match '/add_new_group_member', to: 'contacts#add_new_group_contact', via: 'post'
  match '/Thank_You', to: 'groups#thank_you', via: 'get'

  resources :test
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
