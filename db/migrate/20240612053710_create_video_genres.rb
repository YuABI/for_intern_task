class CreateVideoGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :video_genres do |t|
      t.string :name, default: "", null: false, comment: "ジャンル名"
      t.integer :deleted, default: 0, null: false, comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"

      t.timestamps
    end
  end
end
