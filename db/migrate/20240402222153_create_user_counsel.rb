class CreateUserCounsel < ActiveRecord::Migration[7.1]
  def change

    create_table :user_counsels do |t|
      t.bigint :user_id, default: 0, null: false, comment: "顧客"
      t.bigint :member_id, default: 0, null: false, comment: "メンバー"
      t.datetime :counseling_at, comment: "カウンセリング日付"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end

    create_table :user_counsel_details do |t|
      t.bigint :user_counsel_id, default: 0, null: false, comment: "顧客"
      t.integer :counseling_category, default: 0, null: false,comment: "カテゴリー"
      t.string :memo, default: "", null: false, comment: "備考"
      t.integer :deleted, default: 0, null: false,comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"
      t.timestamps
    end



  end
end
