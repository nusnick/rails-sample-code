class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :title
      t.integer :author_id
      t.boolean :published, :default => true
      t.string :favor
      t.text :teaser
      t.text :full_text
      t.attachment :image

      t.timestamps
    end
  end
end
