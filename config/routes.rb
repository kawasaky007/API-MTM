Rails.application.routes.draw do
  # authorization
  post '/admin/auth/signin', to: 'admin#signin'

  %w(web app).each do |device|
    post "/#{device}/auth/signin", to: 'app#signin'
    post "/#{device}/auth/signup", to: 'app#signup'
    post "/#{device}/auth/code/check", to: 'app#check_code'
    post "/#{device}/auth/code/send", to: 'app#send_code'
  end

  namespace :v1 do
    namespace :admin do
      resources :banners
      resources :products
      resources :categories
      resources :sales
      resources :users
    end
  end


  namespace :v1 do
    %w(web app).each do |device|
      namespace device, module: :app do
        resources :banners, only: :index

        resources :categories, only: %i[index show] do
          member do
            get :products
            get :brands
          end
          collection do
            get :hot_categories
            get :home_page
            get :brands
          end
        end

        resources :sales, only: %i[show] do
          member do
            get :products
          end

          collection do
            get :popup
            get :flash_sale
          end
        end

        resources :products, only: %i[index show] do
          member do
            post "/order", to: 'products#add_to_order'
            delete "/order", to: 'products#remove_from_order'
          end

          collection do
            get :new_products
            get :hot_products
            get :sale_off
            get :flash_sale_info
          end
        end

        resources :users, only: :destroy do
          collection do
            get :show_profile
            post :forget_password
            post :update_password
            put :update_profile
          end
        end

        resources :orders, only: %i[index show create] do 
          collection do
            get :shoping_cart
            get :transport_method
            get :recent_addresses
          end
        end
      end
    end
  end
end
