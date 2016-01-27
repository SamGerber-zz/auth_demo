Rails.application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:new, :create, :show]
end
