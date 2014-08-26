class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :place
      t.string     :title
      t.text       :description
      t.date       :date

      t.timestamps
    end
  end
end
