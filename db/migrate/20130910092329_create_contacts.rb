class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :user
      t.string :city
      t.string :country
      t.string :phone
      t.string :address
      t.string :skype
      t.text :facebook_link
      t.text :vkontakte_link
      t.text :twitter_link
      t.text :linkedin_link
      t.text :website_link
      t.timestamps
    end
  end
end
