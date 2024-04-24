class AsnicaInitializer < ActiveRecord::Migration[7.0]
  def change
    create_table :system_configs, comment: "システム設定", force: :cascade do |t|
      t.string :site_url, defult: "", null: false, comment: "サイトURL"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :system_configs, :deleted

    SystemConfig.create!(site_url: 'http://localhost:3000/')

    create_table :admin_users, comment: "管理者", force: :cascade do |t|
      t.string :name, default: "", null: false, comment: "氏名"
      t.string :email, default: "", null: false, comment: "メールアドレス"
      t.string :hashed_password, default: "", null: false, comment: "ハッシュパスワード"
      t.string :salt
      t.datetime :last_logined_at, comment: "最終ログイン日時"
      t.boolean :available, default: true, null: false, comment: "有効ならtrue"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    add_index :admin_users, :email
    add_index :admin_users, :deleted
    add_index :admin_users, [:email,:deleted]

    p ENV['MATER_ADMIN_USER_PASSWORD']
    if ENV['MATER_ADMIN_USER_PASSWORD'] # nilでmigrationしてしまったらconsoleで作成してください
      attr = {name: 'アスニカ', email: 'info@asnica.co.jp', password: ENV['MATER_ADMIN_USER_PASSWORD']}
      admin_user = AdminUser.new(attr)
      admin_user.save!
    end

    create_table :users, comment: "顧客", force: :cascade do |t|
      t.string :email, default: "", null: false, comment: "メールアドレス"
      t.string :hashed_password, default: "", null: false, comment: "ハッシュパスワード"
      t.string :salt
      t.integer :sex, default: 0, null: false
      t.date :birthday, comment: "誕生日"
      t.string :tel, default: "", null: false, comment: "電話番号"
      t.string :modile_tel, default: "", null: false, comment: "携帯番号"
      t.string :family_name, default: "", null: false, comment: "姓"
      t.string :first_name, default: "", null: false, comment: "名"
      t.string :family_name_kana, default: "", null: false, comment: "姓カナ"
      t.string :first_name_kana, default: "", null: false, comment: "名カナ"
      t.string :company_name, default: "", null: false, comment: "会社名"
      t.string :division_name, default: "", null: false, comment: "部署名"
      t.string :position_name, default: "", null: false, comment: "役職名"
      t.datetime :last_logined_at, comment: "最終ログイン日時"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :users, :email
    add_index :users, :deleted
    add_index :users, [:email,:deleted]

    create_table :addresses, comment: "住所", id: :serial, force: :cascade do |t|
      t.bigint :user_id,default: 0, null: false, comment: "顧客"
      t.string :zip,  default: "", null: false, comment: "郵便番号"
      t.string :pref,  default: "", null: false, comment: "都道府県"
      t.text   :city, default: "", null: false, comment: "市区町村"
      t.string :address1,  default: "", null: false, comment: "番地"
      t.string :address2,  default: "", null: false, comment: "建物名"
      t.string :address_type,  default: "", null: false, comment: "住所区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :addresses, :user_id
    add_index :addresses, :deleted
    add_index :addresses, [:user_id,:deleted]

    create_table :user_inquiries, comment: "顧客問い合わせ", id: :serial, force: :cascade do |t|
      t.bigint :user_id,default: 0, null: false, comment: "顧客"
      t.string :member_id, default: "", null: false, comment: "会員"
      t.datetime :inquiry_at, comment: "問い合わせ日時"
      t.string :content, default: "", null: false, comment: "内容"
      t.integer :mode, default: 0, null: false,comment: "区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :user_inquiries, :user_id
    add_index :user_inquiries, :member_id
    add_index :user_inquiries, :deleted
    add_index :user_inquiries, [:user_id,:deleted]

    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id, :unique => true
    add_index :sessions, :updated_at

    create_table "zip_lists", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "zip"
      t.string "pref_kana"
      t.string "city_kana"
      t.string "town_kana"
      t.string "pref"
      t.string "city"
      t.string "town"
      t.string "pref_en"
      t.string "city_en"
      t.string "town_en"
      t.string "address"
      t.index ["pref"], name: "index_zip_lists_on_pref"
      t.index ["zip"], name: "index_zip_lists_on_zip"
    end
  end
end
