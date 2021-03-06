Rails.application.routes.draw do

  root to: "atividades#index"

  get   "/login", to: "login#new"
  post  "/login", to: "login#create"
  get "/logout", to: "login#destroy"
  get "/usuarios/edit", to:"usuarios#edit"

  resources :rejeicao, as: "rejeitar"
  resources :usuarios, only: [:new, :create, :edit, :update]
  resources :comprovantes, only: [:new, :create]
  resources :declaracoes

  resources :atividades do
    member do
      get :avalia
      get :valida
      get :confirma
      get :cancela
      put :remove_arquivo
    end
  end

  get 'declaracoes', to: 'declaracoes#validar_declaracao'
  get 'validar_declaracao_index', to: 'declaracoes#validar_declaracao_index'
  post 'validar_declaracao', to: 'declaracoes#validar_declaracao'
  get "declaracao_atividades_:hora.pdf", to: 'declaracoes#declaracao_atividades', format: 'pdf', as: "declaracao_atividades"
  get "relatorio_atividades_:hora.pdf", to: 'declaracoes#relatorio_atividades', format: 'pdf', as: "relatorio_atividades"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
