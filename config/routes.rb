Rails.application.routes.draw do
  # create routes only for create and new
  resources :posts, only: %i[create new] do
    # define additional routes nested under the posts resource.
    resources :comments, only: %i[create new]
    resources :likes, only: :create do
      collection do
        delete :destroy
      end
    end
  end
  devise_for :users, controllers: { registrations: "registrations" }
  # define a custom route for the "/users" path
  resources :users, only: %i[index show]
  root 'site#index', as: :sites
  get "*path", to: "errors#not_found"
end
