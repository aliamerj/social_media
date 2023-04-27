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
  resources :users, only: %i[index show] do
    resources :friendships, only: :create do
  # we use the collection block to define a set of routes
  # that operate on the collection of resources as a whole.
  # In this case, we're defining a delete route
  # that will operate on all friendships, not just a specific one.
      collection do
        delete :destroy
      end
    end
  end
  root 'site#index', as: :sites
  get "*path", to: "errors#not_found", constraints: lambda { |req|
  !req.path.start_with?("/rails/active_storage")
}
end
