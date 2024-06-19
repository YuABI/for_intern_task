class CreateVideoChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :video_channels do |t|
      t.text :URL, default: "", null: false, comment: "URL"
      t.string :title, default: "", null: false, comment: "タイトル" #28字以下にする
      t.string :explanation, default: "", null: false, comment: "詳細説明"
      t.references :video_genre, foreign_key: true
      t.integer :deleted, default: 0, null: false, comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"


      t.timestamps
    end
  end
end
