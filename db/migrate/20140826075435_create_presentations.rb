class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.references :event,      index: true
      t.string     :uuid,       null:  false
      t.string     :title
      t.text       :description
      t.string     :video
      t.string     :video_tmp

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
