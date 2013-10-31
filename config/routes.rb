Iou::Application.routes.draw do
  root :to => 'bills#new'

  resources :bills

  resources :users, :except => [:index, :destroy]

  resources :session, :only => [:new, :create, :destroy]
end
