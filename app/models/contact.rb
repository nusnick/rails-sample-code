class Contact < ActiveRecord::Base

  ### VALIDATIONS ###
  validates_length_of :city, maximum: 100
  validates_length_of :phone, maximum: 15
  validates_length_of :address, maximum: 255
  validates_length_of :skype, maximum: 32
  validates_length_of [:facebook_link, :vkontakte_link, :twitter_link, :linkedin_link, :website_link], maximum: 2048

  ### ASSOCIATIONS ###
  belongs_to :user
end
