class CreateInvoices < ActiveRecord::Migration[7.1]
  def change

    add_column :organizations, :invoice_number, :string, comment: "インボイス登録番号"
    add_column :organizations, :payment_term_to_user, :text, comment: "顧客宛支払い条件" # ご請求日より５営業日以内にお支払いください。

    create_table :transfers, force: :cascade, comment: "銀行口座" do |t|
      t.bigint :organization_id, default: 0, null: false, comment: "組織"
      t.string :name, default: "", null: false, comment: "名称"
      t.string :bank_name, default: "", null: false, comment: "金融機関名"
      t.string :bank_code, default: "", null: false, comment: "金融機関番号"
      t.string :bank_branch_name, default: "", null: false, comment: "支店"
      t.string :bank_branch_code, default: "", null: false, comment: "支店コード"
      t.integer :bank_type, default: 0, null: false, comment: "預金種別（普通、当座、貯蓄）"
      t.string :bank_user_name, default: "", null: false, comment: "口座名義"
      t.string :bank_user_code, default: "", null: false, comment: "口座番号"
      t.integer :available, default: 1, null: false,comment: "利用区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    create_table :invoices, force: :cascade, comment: "請求書" do |t|
      t.bigint :user_id, default: 0, null: false, comment: "顧客"
      t.bigint :member_id, default: 0, null: false, comment: "作成した会員"
      t.bigint :organization_id, default: 0, null: false, comment: "組織"
      t.string :invoice_code, default: "", null: false, comment: "請求書番号"
      t.integer :invoice_status_id, default: 0, null: false, comment: "請求ステータス"
      t.integer :total_price, default: 0, null: false, comment: "請求金額"
      t.integer :tax_rate, default: 0, null: false, comment: "税率"
      t.datetime :regstered_at, comment: "請求ステータス"
      t.text :title, default: "", null: false, comment: "件名"
      t.text :payment_term_to_user, default: "", null: false, comment: "顧客宛支払い条件"
      t.bigint :transfer_id, default: 0, null: false, comment: "振込先"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    add_index :invoices, :user_id
    add_index :invoices, :invoice_code
    add_index :invoices, :deleted
    add_index :invoices, [:user_id,:deleted]

    create_table :invoice_details, force: :cascade, comment: "請求書明細" do |t|
      t.bigint :invoice_id, default: 0, null: false, comment: "請求書"
      t.bigint :product_detail_id, default: 0, null: false, comment: "商材明細"
      t.integer :price, default: 0, null: false, comment: "単価"
      t.integer :qty, default: 1, null: false, comment: "数量"
      t.integer :tax_rate, default: 0, null: false, comment: "税率"
      t.text :content, default: "", null: false, comment: "明細名"
      t.integer :mode, default: 0, null: false, comment: "区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    add_index :invoice_details, :invoice_id
    add_index :invoice_details, :product_detail_id
    add_index :invoice_details, :deleted
    add_index :invoice_details, [:invoice_id,:deleted]
    add_index :invoice_details, [:product_detail_id,:deleted]

    create_table :products, force: :cascade, comment: "商材" do |t|
      t.string :name, default: "", null: false, comment: "名称"
      t.string :code, default: "", null: false, comment: "コード"
      t.string :invoice_detail_name, default: "", null: false, comment: "請求書明細名"
      t.integer :available, default: 1, null: false,comment: "利用区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    add_index :products, :deleted

    create_table :product_category, force: :cascade, comment: "商材カテゴリー" do |t|
      t.string :name, default: "", null: false, comment: "名称"
      t.string :code, default: "", null: false, comment: "コード"
      t.integer :available, default: 1, null: false,comment: "利用区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    create_table :product_options, force: :cascade, comment: "商材オプション" do |t|
      t.bigint :product_category_id, default: 0, null: false, comment: "商材カテゴリー"
      t.string :name, default: "", null: false, comment: "名称"
      t.string :code, default: "", null: false, comment: "コード"
      t.integer :price, default: 0, null: false,comment: "料金"
      t.integer :cycle_type, default: 0, null: false,comment: "サイクルタイプ（単発or定期）"
      t.integer :cycle_schedule, default: 0, null: false,comment: "サイクル時の期間数（○ヶ月）" # 1ヶ月は1、1年は12を指定することにする
      t.integer :available, default: 1, null: false,comment: "利用区分"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    add_index :product_options, :product_category_id
    add_index :product_options, :deleted
    add_index :product_options, [:product_category_id,:deleted]

    create_table :product_option_mappings, force: :cascade, comment: "商材・商材オプション中間テーブル" do |t|
      t.bigint :product_id, default: 0, null: false, comment: "商材"
      t.bigint :product_option_id, default: 0, null: false, comment: "商材オプション"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

  end
end
