Rails.application.routes.draw do
  resources :question_groups
  devise_for :users
  resources :options
  resources :questions
  resources :levels
  resources :categories
  root 'admins#dashboard'
  get "passage_questions" => "questions#passage_questions"
  get "passage_questions/new" => "questions#new_passage_question"
  get "start_test" => "candidates#start_test"
  get "candidate/:session_question_group_id/question/:session_question_group_question_id" => "candidates#show_question", as: "candidate_question"
  get "candidate/message" => "candidates#show_message", as: "show_message"
  patch "candidate/:session_question_group_id/question/:session_question_group_question_id" => "candidates#answer_question", as: "answer_question"


  get "candidate/session/:candidate_sesion_token/question/:question_number" => "candidates#show_session_question", as: "candidate_session_question"

  patch "candidate/session/:candidate_sesion_token/question/:question_number" => "candidates#answer_session_question", as: "answer_candidate_session_question"



  resources :candidates
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
