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

ActiveRecord::Schema[7.1].define(version: 2024_04_11_054430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, comment: "住所", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.string "zip", default: "", null: false, comment: "郵便番号"
    t.string "pref", default: "", null: false, comment: "都道府県"
    t.text "city", default: "", null: false, comment: "市区町村"
    t.string "address1", default: "", null: false, comment: "番地"
    t.string "address2", default: "", null: false, comment: "建物名"
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

  create_table "member_users", comment: "顧客と会員・パートナーの中間", force: :cascade do |t|
    t.bigint "member_id", default: 0, null: false, comment: "会員・パートナー"
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_member_users_on_deleted"
    t.index ["user_id", "deleted"], name: "index_member_users_on_user_id_and_deleted"
  end

  create_table "members", comment: "会員・パートナー", force: :cascade do |t|
    t.bigint "organization_id", default: 0, null: false, comment: "組織"
    t.string "email", default: "", null: false, comment: "メールアドレス"
    t.string "hashed_password", default: "", null: false, comment: "ハッシュパスワード"
    t.string "salt"
    t.datetime "last_logined_at", comment: "最終ログイン日時"
    t.string "tel", default: "", null: false, comment: "電話番号"
    t.string "mobile_tel", default: "", null: false, comment: "携帯番号"
    t.string "family_name", default: "", null: false, comment: "姓"
    t.string "first_name", default: "", null: false, comment: "名"
    t.string "family_name_kana", default: "", null: false, comment: "姓カナ"
    t.string "first_name_kana", default: "", null: false, comment: "名カナ"
    t.integer "available", default: 1, null: false, comment: "利用区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_members_on_deleted"
    t.index ["email", "deleted"], name: "index_members_on_email_and_deleted"
    t.index ["email"], name: "index_members_on_email"
  end

  create_table "organizations", comment: "組織", force: :cascade do |t|
    t.string "name", default: "", null: false, comment: "名称"
    t.string "zip", comment: "郵便番号"
    t.string "pref", comment: "都道府県"
    t.text "city", comment: "市区町村"
    t.string "address1", comment: "番地"
    t.string "address2", comment: "建物名"
    t.string "tel", comment: "電話番号"
    t.string "fax", comment: "FAX番号"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_organizations_on_deleted"
    t.index ["name", "deleted"], name: "index_organizations_on_name_and_deleted"
    t.index ["name"], name: "index_organizations_on_name"
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

  create_table "user_counsel_details", force: :cascade do |t|
    t.bigint "user_counsel_id", default: 0, null: false, comment: "顧客"
    t.integer "counseling_category", default: 0, null: false, comment: "カテゴリー"
    t.string "memo", default: "", null: false, comment: "備考"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_counsels", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.bigint "member_id", default: 0, null: false, comment: "メンバー"
    t.datetime "counseling_at", comment: "カウンセリング日付"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_inquiries", id: :serial, comment: "顧客問い合わせ", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.string "member_id", default: "", null: false, comment: "会員"
    t.datetime "inquiry_at", comment: "問い合わせ日時"
    t.string "content", default: "", null: false, comment: "内容"
    t.integer "mode", default: 0, null: false, comment: "区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_user_inquiries_on_deleted"
    t.index ["member_id"], name: "index_user_inquiries_on_member_id"
    t.index ["user_id", "deleted"], name: "index_user_inquiries_on_user_id_and_deleted"
    t.index ["user_id"], name: "index_user_inquiries_on_user_id"
  end

  create_table "users", comment: "顧客", force: :cascade do |t|
    t.string "email", default: "", null: false, comment: "メールアドレス"
    t.string "hashed_password", default: "", null: false, comment: "ハッシュパスワード"
    t.string "salt"
    t.integer "sex", default: 0, null: false
    t.date "birthday", comment: "誕生日"
    t.string "tel", default: "", null: false, comment: "電話番号"
    t.string "modile_tel", default: "", null: false, comment: "携帯番号"
    t.string "family_name", default: "", null: false, comment: "姓"
    t.string "first_name", default: "", null: false, comment: "名"
    t.string "family_name_kana", default: "", null: false, comment: "姓カナ"
    t.string "first_name_kana", default: "", null: false, comment: "名カナ"
    t.string "company_name", default: "", null: false, comment: "会社名"
    t.string "division_name", default: "", null: false, comment: "部署名"
    t.string "position_name", default: "", null: false, comment: "役職名"
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
