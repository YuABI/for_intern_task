# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_18_075947) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, comment: "住所", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.string "family_name", default: "", null: false, comment: "姓"
    t.string "first_name", default: "", null: false, comment: "名"
    t.string "family_name_kana", default: "", null: false, comment: "姓カナ"
    t.string "first_name_kana", default: "", null: false, comment: "名カナ"
    t.string "zip", default: "", null: false, comment: "郵便番号"
    t.string "pref", default: "", null: false, comment: "都道府県"
    t.text "city", default: "", null: false, comment: "市区町村"
    t.string "address1", default: "", null: false, comment: "番地"
    t.string "address2", default: "", null: false, comment: "建物名"
    t.string "tel", default: "", null: false, comment: "電話番号"
    t.string "address_type", default: "", null: false, comment: "住所区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_addresses_on_deleted"
    t.index ["user_id", "deleted"], name: "index_addresses_on_user_id_and_deleted"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_users", comment: "管理者", force: :cascade do |t|
    t.string "name", default: "", null: false, comment: "氏名"
    t.string "email", default: "", null: false, comment: "メールアドレス"
    t.string "hashed_password", default: "", null: false, comment: "ハッシュパスワード"
    t.string "salt"
    t.datetime "last_logined_at", comment: "最終ログイン日時"
    t.boolean "available", default: true, null: false, comment: "有効ならtrue"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_admin_users_on_deleted"
    t.index ["email", "deleted"], name: "index_admin_users_on_email_and_deleted"
    t.index ["email"], name: "index_admin_users_on_email"
  end

  create_table "api_clients", comment: "APIクライアント", force: :cascade do |t|
    t.string "name", default: "", null: false, comment: "名称"
    t.string "api_key", default: "", null: false, comment: "APIキー"
    t.string "api_secret_key", default: "", null: false, comment: "シークレットキー"
    t.string "api_access_token", default: "", null: false, comment: "アクセストークン"
    t.datetime "api_access_token_expired_at", comment: "アクセストーク有効期限"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_access_token", "deleted"], name: "index_api_clients_on_api_access_token_and_deleted"
    t.index ["api_access_token"], name: "index_api_clients_on_api_access_token"
    t.index ["deleted"], name: "index_api_clients_on_deleted"
  end

  create_table "api_results", comment: "API実行履歴", force: :cascade do |t|
    t.bigint "api_client_id", null: false
    t.integer "api_status_id", default: 1, null: false, comment: "apiステータス"
    t.text "end_point", default: "", null: false, comment: "エンドポイント"
    t.integer "request_method", default: 0, null: false, comment: "リクエストメソッド"
    t.text "request_body", comment: "リクエスト内容"
    t.string "response_status", comment: "レスポンスステータス"
    t.text "response_body", comment: "レスポンス内容"
    t.datetime "request_at", comment: "リクエスト日時"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_client_id", "deleted"], name: "index_api_results_on_api_client_id_and_deleted"
    t.index ["api_client_id"], name: "index_api_results_on_api_client_id"
    t.index ["api_status_id"], name: "index_api_results_on_api_status_id"
    t.index ["deleted"], name: "index_api_results_on_deleted"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "system_configs", comment: "システム設定", force: :cascade do |t|
    t.string "site_url", null: false, comment: "サイトURL"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_system_configs_on_deleted"
  end

  create_table "user_inquiries", id: :serial, comment: "顧客問い合わせ", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.bigint "admin_user_id", default: 0, null: false, comment: "管理者"
    t.datetime "inquiry_at", comment: "問い合わ日時"
    t.string "content", default: "", null: false, comment: "内容"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_user_inquiries_on_admin_user_id"
    t.index ["deleted"], name: "index_user_inquiries_on_deleted"
    t.index ["user_id", "deleted"], name: "index_user_inquiries_on_user_id_and_deleted"
    t.index ["user_id"], name: "index_user_inquiries_on_user_id"
  end

  create_table "users", comment: "顧客", force: :cascade do |t|
    t.string "email", default: "", null: false, comment: "メールアドレス"
    t.string "hashed_password", default: "", null: false, comment: "ハッシュパスワード"
    t.string "salt"
    t.integer "sex", default: 0, null: false
    t.date "birthday", comment: "誕生日"
    t.datetime "last_logined_at", comment: "最終ログイン日時"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_users_on_deleted"
    t.index ["email", "deleted"], name: "index_users_on_email_and_deleted"
    t.index ["email"], name: "index_users_on_email"
  end

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
