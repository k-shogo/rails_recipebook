class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string  :name

      t.string  :postcode
      t.string  :prefecture
      t.string  :address
      t.decimal :latitude,  precision: 20, scale: 15 # 緯度
      t.decimal :longitude, precision: 20, scale: 15 # 経度
      t.integer :zoom_level

      t.timestamps
    end
  end
end
