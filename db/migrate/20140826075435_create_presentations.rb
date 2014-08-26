class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.references :event
      t.references :category
      t.string     :title
      t.text       :description

      t.timestamps
    end
  end
end
