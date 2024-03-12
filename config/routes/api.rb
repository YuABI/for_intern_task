namespace :api, format: 'json' do
  namespace :v1 do
    post :access_tokens, controller: :base, action: :access_tokens
    api_default_actions = [:index,:show]
    [
      {target: :users                   ,actions: api_default_actions.dup, use_create: true  , use_update: true  , use_destroy: false, use_bulk_create: true ,  use_bulk_update: true , use_bulk_destroy: false},
    ].each do |api_info|
      target_actions = api_info[:actions]
      target_actions << :create  if api_info[:use_create]
      target_actions << :update  if api_info[:use_update]
      target_actions << :destroy if api_info[:use_destroy]


      namespace api_info[:target] do
        patch ":id/update_validation",action: :update_validation, as: :patch_validation if api_info[:use_update]
        post "create_validation", action: :create_validation, as: :post_validation if api_info[:use_create]
      end
      #最後に記述
      resources api_info[:target], only: target_actions do
        match :bulk_create, via: [:post], on: :collection if api_info[:use_bulk_create]
        match :bulk_update, via: [:patch], on: :collection if api_info[:use_bulk_update]
        match :bulk_destroy, via: [:delete], on: :collection if api_info[:use_bulk_destroy]

        case api_info[:target]
        when :users
          collection do
            match :login, via: [:post]
          end
          member do
            match :create_addresses, via: [:post]
            match :update_addresses, via: [:patch]
          end
        end
      end
    end

    match '*unmatched_route', :to => 'base#render_not_found', :via => :all
  end
end


