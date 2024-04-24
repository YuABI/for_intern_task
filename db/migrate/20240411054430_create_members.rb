class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members, force: :cascade, comment: "会員・パートナー" do |t|
      t.bigint :organization_id, default: 0, null: false, comment: "組織"
      t.string :email, default: "", null: false, comment: "メールアドレス"
      t.string :hashed_password, default: "", null: false, comment: "ハッシュパスワード"
      t.string :salt
      t.datetime :last_logined_at, comment: "最終ログイン日時"
      t.string :tel, default: "", null: false, comment: "電話番号"
      t.string :mobile_tel, default: "", null: false, comment: "携帯番号"
      t.string :family_name, default: "", null: false, comment: "姓"
      t.string :first_name, default: "", null: false, comment: "名"
      t.string :family_name_kana, default: "", null: false, comment: "姓カナ"
      t.string :first_name_kana, default: "", null: false, comment: "名カナ"
      t.integer :available, default: 1, null: false,comment: "利用区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :members, :email
    add_index :members, :deleted
    add_index :members, [:email,:deleted]

    create_table :member_users, comment: "顧客と会員・パートナーの中間", force: :cascade do |t|
      t.bigint :member_id, default: 0, null: false, comment: "会員・パートナー"
      t.bigint :user_id, default: 0, null: false, comment: "顧客"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :member_users, :deleted
    add_index :member_users, [:user_id,:deleted]

    create_table :organizations, force: :cascade, comment: "組織" do |t|
      t.string :name, default: "", null: false, comment: "名称"
      t.string :zip, comment: "郵便番号"
      t.string :pref, comment: "都道府県"
      t.text   :city, comment: "市区町村"
      t.string :address1, comment: "番地"
      t.string :address2, comment: "建物名"
      t.string :tel, comment: "電話番号"
      t.string :fax, comment: "FAX番号"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end
    add_index :organizations, :name
    add_index :organizations, :deleted
    add_index :organizations, [:name,:deleted]

  end
end
