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

ActiveRecord::Schema[7.1].define(version: 2024_06_21_082511) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "invoice_details", comment: "請求書明細", force: :cascade do |t|
    t.bigint "invoice_id", default: 0, null: false, comment: "請求書"
    t.bigint "product_detail_id", default: 0, null: false, comment: "商材明細"
    t.integer "price", default: 0, null: false, comment: "単価"
    t.integer "qty", default: 1, null: false, comment: "数量"
    t.integer "tax_rate", default: 0, null: false, comment: "税率"
    t.text "content", default: "", null: false, comment: "明細名"
    t.integer "mode", default: 0, null: false, comment: "区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_invoice_details_on_deleted"
    t.index ["invoice_id", "deleted"], name: "index_invoice_details_on_invoice_id_and_deleted"
    t.index ["invoice_id"], name: "index_invoice_details_on_invoice_id"
    t.index ["product_detail_id", "deleted"], name: "index_invoice_details_on_product_detail_id_and_deleted"
    t.index ["product_detail_id"], name: "index_invoice_details_on_product_detail_id"
  end

  create_table "invoices", comment: "請求書", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, comment: "顧客"
    t.bigint "member_id", default: 0, null: false, comment: "作成した会員"
    t.bigint "organization_id", default: 0, null: false, comment: "組織"
    t.string "invoice_code", default: "", null: false, comment: "請求書番号"
    t.integer "invoice_status_id", default: 0, null: false, comment: "請求ステータス"
    t.integer "total_price", default: 0, null: false, comment: "請求金額"
    t.integer "tax_rate", default: 0, null: false, comment: "税率"
    t.datetime "regstered_at", comment: "請求ステータス"
    t.text "title", default: "", null: false, comment: "件名"
    t.text "payment_term_to_user", default: "", null: false, comment: "顧客宛支払い条件"
    t.bigint "transfer_id", default: 0, null: false, comment: "振込先"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_invoices_on_deleted"
    t.index ["invoice_code"], name: "index_invoices_on_invoice_code"
    t.index ["user_id", "deleted"], name: "index_invoices_on_user_id_and_deleted"
    t.index ["user_id"], name: "index_invoices_on_user_id"
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
    t.string "invoice_number", comment: "インボイス登録番号"
    t.text "payment_term_to_user", comment: "顧客宛支払い条件"
    t.index ["deleted"], name: "index_organizations_on_deleted"
    t.index ["name", "deleted"], name: "index_organizations_on_name_and_deleted"
    t.index ["name"], name: "index_organizations_on_name"
  end

  create_table "product_category", comment: "商材カテゴリー", force: :cascade do |t|
    t.string "name", default: "", null: false, comment: "名称"
    t.string "code", default: "", null: false, comment: "コード"
    t.integer "available", default: 1, null: false, comment: "利用区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_option_mappings", comment: "商材・商材オプション中間テーブル", force: :cascade do |t|
    t.bigint "product_id", default: 0, null: false, comment: "商材"
    t.bigint "product_option_id", default: 0, null: false, comment: "商材オプション"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_options", comment: "商材オプション", force: :cascade do |t|
    t.bigint "product_category_id", default: 0, null: false, comment: "商材カテゴリー"
    t.string "name", default: "", null: false, comment: "名称"
    t.string "code", default: "", null: false, comment: "コード"
    t.integer "price", default: 0, null: false, comment: "料金"
    t.integer "cycle_type", default: 0, null: false, comment: "サイクルタイプ（単発or定期）"
    t.integer "cycle_schedule", default: 0, null: false, comment: "サイクル時の期間数（○ヶ月）"
    t.integer "available", default: 1, null: false, comment: "利用区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_product_options_on_deleted"
    t.index ["product_category_id", "deleted"], name: "index_product_options_on_product_category_id_and_deleted"
    t.index ["product_category_id"], name: "index_product_options_on_product_category_id"
  end

  create_table "products", comment: "商材", force: :cascade do |t|
    t.string "name", default: "", null: false, comment: "名称"
    t.string "code", default: "", null: false, comment: "コード"
    t.string "invoice_detail_name", default: "", null: false, comment: "請求書明細名"
    t.integer "available", default: 1, null: false, comment: "利用区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted"], name: "index_products_on_deleted"
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

  create_table "transfers", comment: "銀行口座", force: :cascade do |t|
    t.bigint "organization_id", default: 0, null: false, comment: "組織"
    t.string "name", default: "", null: false, comment: "名称"
    t.string "bank_name", default: "", null: false, comment: "金融機関名"
    t.string "bank_code", default: "", null: false, comment: "金融機関番号"
    t.string "bank_branch_name", default: "", null: false, comment: "支店"
    t.string "bank_branch_code", default: "", null: false, comment: "支店コード"
    t.integer "bank_type", default: 0, null: false, comment: "預金種別（普通、当座、貯蓄）"
    t.string "bank_user_name", default: "", null: false, comment: "口座名義"
    t.string "bank_user_code", default: "", null: false, comment: "口座番号"
    t.integer "available", default: 1, null: false, comment: "利用区分"
    t.integer "deleted", default: 0, null: false, comment: "削除区分"
    t.datetime "deleted_at", comment: "削除日時"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "user_lifeplan_assets", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "user_lifeplan_id", null: false
    t.integer "rate", default: 0, null: false
    t.string "other_assets_kind", default: "", null: false
    t.string "financial_institution_name", default: "", null: false
    t.string "store_name", default: "", null: false
    t.string "cache_deposit_kind", default: "", null: false
    t.string "account_number", default: "", null: false
    t.date "reference_on"
    t.integer "amount_of_money", default: 0, null: false
    t.string "content", default: "", null: false
    t.string "company_name", default: "", null: false
    t.integer "asset_appraisal_value", default: 0, null: false
    t.integer "equity_appraisal_value", default: 0, null: false
    t.integer "scheduled_for_sale", default: 0, null: false
    t.integer "sundry_expenses", default: 0, null: false
    t.integer "profit", default: 0, null: false
    t.string "description", default: "", null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_lifeplan_asset_kind", default: "", null: false
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_assets_on_user_lifeplan_id"
  end

  create_table "user_lifeplan_beneficiaries", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "user_lifeplan_id", null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_beneficiaries_on_user_lifeplan_id"
  end

  create_table "user_lifeplan_contacts", force: :cascade do |t|
    t.bigint "user_lifeplan_id", null: false
    t.string "user_lifeplan_contact_kind", default: "", null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_level_kind", default: "", null: false
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_contacts_on_user_lifeplan_id"
  end

  create_table "user_lifeplan_expenses", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "expenditure_item_name", default: "", null: false
    t.bigint "user_lifeplan_id", null: false
    t.string "content", default: "", null: false
    t.string "company_name", default: "", null: false
    t.string "note", default: "", null: false
    t.integer "monthly_amount", default: 0, null: false
    t.integer "pay_by_years", default: 0, null: false
    t.integer "yearly_amount", default: 0, null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_lifeplan_expense_kind", default: "", null: false
    t.string "spending_item", default: "", null: false
    t.integer "payment_start_year", default: 0, null: false
    t.integer "payment_end_year", default: 0, null: false
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_expenses_on_user_lifeplan_id"
  end

  create_table "user_lifeplan_finance_conditions", force: :cascade do |t|
    t.bigint "user_lifeplan_id", null: false
    t.integer "user_lifeplan_finance_condition_status_id", default: 1, null: false
    t.date "until_submitted_on"
    t.string "account", default: "", null: false
    t.string "account_info", default: "", null: false
    t.integer "balance", default: 0, null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "confirmed_on"
    t.string "finance_condition_kind", default: "", null: false
    t.string "content", default: "", null: false
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_finance_conditions_on_user_lifeplan_id"
  end

  create_table "user_lifeplan_incomes", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "user_lifeplan_id", null: false
    t.string "cache_income_kind", default: "", null: false
    t.string "pension_kind", default: "", null: false
    t.string "content", default: "", null: false
    t.string "company_name", default: "", null: false
    t.integer "monthly_amount", default: 0, null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_lifeplan_income_kind", default: "", null: false
    t.integer "yearly_amount", default: 0, null: false
    t.integer "payment_start_year", default: 0, null: false
    t.integer "payment_end_year", default: 0, null: false
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_incomes_on_user_lifeplan_id"
  end

  create_table "user_lifeplan_remand_histories", force: :cascade do |t|
    t.bigint "user_lifeplan_id"
    t.bigint "admin_user_id"
    t.datetime "remanded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_user_lifeplan_remand_histories_on_admin_user_id"
    t.index ["user_lifeplan_id"], name: "index_user_lifeplan_remand_histories_on_user_lifeplan_id"
  end

  create_table "user_lifeplans", force: :cascade do |t|
    t.integer "user_lifeplan_status_id", default: 1, null: false
    t.datetime "review_requested_at"
    t.datetime "review_completed_at"
    t.string "background_reason", default: "", null: false
    t.string "background_reason_comment", default: "", null: false
    t.string "legal_heir", default: "", null: false
    t.string "legal_heir_comment", default: "", null: false
    t.string "residue", default: "", null: false
    t.string "relatives", default: "", null: false
    t.string "relatives_comment", default: "", null: false
    t.string "household_disposal", default: "", null: false
    t.string "real_estate_disposal", default: "", null: false
    t.string "close_grave", default: "", null: false
    t.string "funeral_memorial_policy", default: "", null: false
    t.string "small_account", default: "", null: false
    t.string "note", default: "", null: false
    t.integer "deleted", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "member_id", null: false
    t.text "contact_note", default: "", null: false
    t.text "contact_inspect_note", default: "", null: false
    t.date "basis_on"
    t.integer "start_pension_age", default: 0, null: false
    t.integer "start_resident_elderly_facility_age", default: 0, null: false
    t.integer "start_nursing_care_age", default: 0, null: false
    t.integer "death_age", default: 0, null: false
    t.integer "review_started_at"
    t.bigint "admin_user_id"
    t.index ["admin_user_id"], name: "index_user_lifeplans_on_admin_user_id"
    t.index ["member_id"], name: "index_user_lifeplans_on_member_id"
    t.index ["user_id"], name: "index_user_lifeplans_on_user_id"
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

  create_table "video_channels", force: :cascade do |t|
    t.text "URL"
    t.string "title"
    t.string "explanation"
    t.bigint "video_genre_id"
    t.integer "deleted"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_genre_id"], name: "index_video_channels_on_video_genre_id"
  end

  create_table "video_channels_video_tags", force: :cascade do |t|
    t.bigint "video_channel_id"
    t.bigint "video_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_channel_id"], name: "index_video_channels_video_tags_on_video_channel_id"
    t.index ["video_tag_id"], name: "index_video_channels_video_tags_on_video_tag_id"
  end

  create_table "video_genres", force: :cascade do |t|
    t.string "name"
    t.integer "deleted"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "video_tags", force: :cascade do |t|
    t.string "tag_name"
    t.integer "deleted"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "user_lifeplan_assets", "user_lifeplans"
  add_foreign_key "user_lifeplan_beneficiaries", "user_lifeplans"
  add_foreign_key "user_lifeplan_contacts", "user_lifeplans"
  add_foreign_key "user_lifeplan_expenses", "user_lifeplans"
  add_foreign_key "user_lifeplan_finance_conditions", "user_lifeplans"
  add_foreign_key "user_lifeplan_incomes", "user_lifeplans"
  add_foreign_key "user_lifeplans", "admin_users"
  add_foreign_key "user_lifeplans", "users"
  add_foreign_key "video_channels", "video_genres"
  add_foreign_key "video_channels_video_tags", "video_channels"
  add_foreign_key "video_channels_video_tags", "video_tags"
end
