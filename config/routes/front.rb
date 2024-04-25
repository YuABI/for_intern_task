scope module: "front" do

  root "base#dashboard", as: :front_root
  match :login, controller: :base, action: :login, via: [:get, :post], as: :front_login
  get :logout, controller: :base, action: :logout, as: :front_logout
  get  'get_file', controller: :master, action: :get_file

  [
    :users,
  ].each do |sym|
    namespace sym do

    end
    #最後に記述
    resources sym do
      # 検索フォームの検索条件クリア（ajax）（patch,getは不要）
      match :search_clear, via: [:get, :post,:patch], on: :collection
      # 検索フォームによる検索（ajax）（patch,getは不要）
      match :search, via: [:get, :post,:patch], on: :collection
      match :generate_csv, via: [:post], on: :collection
      match :get_file, via: [:get], on: :collection

    end
  end
end
