class CreateSolutionSpecializations < ActiveRecord::Migration
  def change
    create_table :solution_specializations do |t|
      t.string :title
      t.boolean :published, :default => true
      t.integer :author_id
      t.timestamps
    end
  end
end
