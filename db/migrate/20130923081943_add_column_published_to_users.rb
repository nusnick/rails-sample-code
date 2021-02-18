class AddColumnPublishedToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :status
    add_column    :users, :published, :boolean, :default => true
  end
end
