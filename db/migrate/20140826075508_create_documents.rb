class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :presentation, index: true
      t.string     :title
      t.text       :description

      t.timestamps
    end
  end
end
