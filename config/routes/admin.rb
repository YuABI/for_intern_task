namespace :admin do
  root "base#dashboard"
  match :login, controller: :base, action: :login, via: [:get, :post]
  get :logout, controller: :base, action: :logout
  get  :get_file, controller: :master, action: :get_file


  [
    :users,
    :members, :organizations,
    :invoices,
    :trust_companies, :insurance_companies, :products, :product_options,
    :notifications, :video_channels, :video_tags, :video_genres,
    :api_results,
    :system_configs,:admin_users, :api_clients,
    :system_configs,:admin_users,:api_clients,
    # TODO: 試しにマスターコントローラを実装
    :user_lifeplans,
  ].each do |sym|
    namespace sym do
      case sym
      when :xxx
      end
    end
    #最後に記述
    resources sym do
      # 検索フォームの検索条件クリア（ajax）（patch,getは不要）
      match :search_clear, via: [:get, :post,:patch], on: :collection
      # 検索フォームによる検索（ajax）（patch,getは不要）
      match :search, via: [:get, :post,:patch], on: :collection
      match :generate_csv, via: [:get, :post,:patch], on: :collection
      match :csv_import, via: [:get, :post,:patch], on: :collection
      match :csv_update, via: [:get, :post,:patch], on: :collection

      case sym

      when :api_clients
        member do
          match :api_key, via: [:get,:post]
        end
      when :users
        collection do
          match :add_address, via: [:post,:patch]
          match :del_address, via: [:post,:patch]
          match :add_user_inquiry, via: [:post,:patch]
          match :del_user_inquiry, via: [:post,:patch]

        end
      when :user_lifeplans
        scope module: :user_lifeplans do
          resource :confirmations, only: %i[show update], controller: :user_lifeplan_confirmations
          resource :review_remands, only: %i[update], controller: :review_remands
          resource :review_completes, only: %i[update], controller: :review_completes
        end
        collection do
          match :add_user_lifeplan_asset, via: [:post,:patch]
          match :del_user_lifeplan_asset, via: [:post,:patch]

          match :add_user_lifeplan_income, via: [:post,:patch]
          match :del_user_lifeplan_income, via: [:post,:patch]

          match :add_user_lifeplan_expense, via: [:post,:patch]
          match :del_user_lifeplan_expense, via: [:post,:patch]

          match :add_user_lifeplan_finance_condition, via: [:post,:patch]
          match :del_user_lifeplan_finance_condition, via: [:post,:patch]

          match :add_user_lifeplan_contact, via: [:post,:patch]
          match :del_user_lifeplan_contact, via: [:post,:patch]

          match :add_user_lifeplan_beneficiary, via: [:post,:patch]
          match :del_user_lifeplan_beneficiary, via: [:post,:patch]

        end
      end

    end
  end
end
