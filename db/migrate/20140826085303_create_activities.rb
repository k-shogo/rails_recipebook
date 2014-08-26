class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :trackable, polymorphic: true
      t.belongs_to :owner,     polymorphic: true
      t.string     :key
      t.text       :parameters
      t.belongs_to :recipient, polymorphic: true

      t.timestamps


      t.index [:trackable_id, :trackable_type]
      t.index [:owner_id,     :owner_type]
      t.index [:recipient_id, :recipient_type]
    end
  end
end
