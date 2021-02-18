class CreateSolutionsSpecializations < ActiveRecord::Migration
  def change
    create_table :solutions_specs do |t|
      t.integer :solution_id
      t.integer :spec_id
    end

    add_index :solutions_specs, [:solution_id, :spec_id], :unique => true
  end
end
