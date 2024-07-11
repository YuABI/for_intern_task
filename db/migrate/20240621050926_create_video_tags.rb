class CreateVideoTags < ActiveRecord::Migration[7.1]
  def change
    create_table :video_tags do |t|
      t.string :tag_name, default: "", null: false, comment: "タグの名前"
      t.integer :deleted, default: 0, null: false, comment: "削除区分"
      t.datetime :deleted_at, comment: "削除日時"

      t.timestamps
    end
  end
end
