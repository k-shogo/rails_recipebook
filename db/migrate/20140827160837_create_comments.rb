class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.references :user
      t.string :body

      t.timestamps
    end
  end
end
