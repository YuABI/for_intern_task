namespace :members do

  root "base#dashboard"
  match :login, controller: :base, action: :login, via: [:get, :post]
  get :logout, controller: :base, action: :logout
  get  'get_file', controller: :master, action: :get_file

  [
    :users,
    :user_lifeplans
  ].each do |sym|
    namespace sym do
      case sym
      when :users
        get  ":id/user_counsel", action: :user_counsel, as: :user_counsel
      end

    end
    #最後に記述
    resources sym do
      # 検索フォームの検索条件クリア（ajax）（patch,getは不要）
      match :search_clear, via: [:get, :post,:patch], on: :collection
      # 検索フォームによる検索（ajax）（patch,getは不要）
      match :search, via: [:get, :post,:patch], on: :collection
      match :generate_csv, via: [:post], on: :collection
      match :get_file, via: [:get], on: :collection

      case sym
      when :users
        collection do
          match :add_address, via: [:post,:patch]
          match :del_address, via: [:post,:patch]
        end
      when :user_lifeplans
        scope module: :user_lifeplans do
          resource :confirmations, only: %i[show update]
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
