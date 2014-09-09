class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :trackable, polymorphic: true, index: true
      t.belongs_to :owner,     polymorphic: true, index: true
      t.string     :key
      t.text       :parameters
      t.belongs_to :recipient, polymorphic: true ,index: true

      t.timestamps
    end
  end
end
