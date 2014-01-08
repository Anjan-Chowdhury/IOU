Iou::Application.routes.draw do
  root :to => 'bills#new'

  resources :bills
  match '/bills/:id/billconfirmation' => 'bills#billconfirmation', :via => :post, :as => :billconfirmation

	resources :debts, :only => [:create, :new, :show]
	match '/payments/new', :to => 'debts#new'
  match '/debts/:id/paymentconfirmation' => 'debts#paymentconfirmation', :via => :post, :as => :paymentconfirmation

  resources :session, :only => [:create, :destroy, :new]
  get "logout" => "session#destroy", :as => "logout"

  resources :users, :except => [:destroy, :index]
  match '/:id' => 'users#show', :as => :user
end