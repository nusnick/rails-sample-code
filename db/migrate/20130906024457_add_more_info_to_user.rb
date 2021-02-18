class AddMoreInfoToUser < ActiveRecord::Migration
  def change
    add_attachment :users,:avatar
    add_column :users, :full_name, :string
    add_column :users, :status, :string
    add_column :users, :karma, :string
    add_column :users, :services, :text
    add_column :users, :about, :text
    add_column :users, :additional_info, :text
  end
end
