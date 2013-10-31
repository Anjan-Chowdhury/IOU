Iou::Application.routes.draw do
  root :to => 'bills#new'

  resources :bills

  resources :session, :only => [:new, :create, :destroy]
end
