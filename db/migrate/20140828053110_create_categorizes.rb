class CreateCategorizes < ActiveRecord::Migration
  def change
    create_table :categorizes do |t|
      t.references :presentation
      t.references :category

      t.timestamps

      t.index [:presentation_id, :category_id], unique: true
    end
  end
end
