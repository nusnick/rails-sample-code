require 'net/http'
class User < ActiveRecord::Base
  rolify

  ### CONSTANTS ###
  STATUS = {
    :published => "published",
    :unpublished => "unpublished"
  }

  ### INCLUDES DEFAULT DEVISE MODULE ###
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ### VALIDATIONS ###
  validates_numericality_of :karma, :greater_than => 0, :less_than => 5001, :allow_blank => true, :message => I18n.t("users.error_on_karma")
  validate :avatar_is_less_than_two_megabytes
  validates_length_of :full_name, maximum: 100
  validates_length_of :email, maximum: 255
  validates_length_of [:about, :additional_info], maximum: 5001

  after_save :switch_role
  before_destroy :can_destroy

  ### ASSOCIATIONS ###
  has_many :solutions, :foreign_key => "author_id", dependent: :destroy
  has_many :solution_specializations, :foreign_key => "author_id", dependent: :destroy
  has_one :contact, dependent: :destroy
  accepts_nested_attributes_for :contact

  has_attached_file :avatar, :styles => { :thumb => "100x100#", :large => "600x600>" },
  :default_style => :thumb, default_url: "avatar_missing.png"
  validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/jpg']

  attr_accessor :role

  scope :search, lambda { |keyword|
    where("published = TRUE AND (LOWER(full_name) LIKE :keyword OR LOWER(email) LIKE :keyword)", {keyword: "%#{keyword.downcase}%"})
  }

  ### FUNCTIONS ###

  def is_admin?
    return has_role?(:super_admin) || has_role?(:admin)
  end

  def active_for_authentication?
    super && self.published?
  end

  def inactive_message
    self.published? ? super : :unpublished
  end

  #display full name or email
  def name
    if full_name.blank?
      email
    else
      full_name
    end
  end

  #Getting avatar url from local or from Gravatar
  def avatar_url
    if avatar.exists?
      avatar.url(:thumb)
    else
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      gravatar_check = "http://gravatar.com/avatar/#{gravatar_id}.png?s=100&d=404"
      uri = URI.parse(gravatar_check)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      if (response.code.to_i == 404)
        avatar.url(:thumb)
      else
        gravatar_check
      end
    end
  end

  def as_json(options)
    json = super(options)
    json[:name] = name
    json
  end

  #Change status of this solution from published to unpublished vice versa
  def toggle_status
    self.published = !published
    self.save
  end

  def self.invite_user params
    password = Devise.friendly_token[0,20]
    params[:password] = password
    params[:password_confirmation] = password

    user = User.new(params)
    user.reset_password_token   = Devise.friendly_token[0,20]
    user.reset_password_sent_at = Time.now.utc
    user
  end

private
  def avatar_is_less_than_two_megabytes
    if self.avatar?
      if self.avatar.size > 2.megabytes
        errors.add(:avatar, I18n.t("users.avatar_file_size_validation"))
      end
    end
  end

  def switch_role
    if self.role
      self.roles = []
      self.add_role(Role.find(self.role).name)
    end
  end

  def can_destroy
    if self.solutions.length > 0 || self.solution_specializations.length > 0
      errors.add(:base, I18n.t("users.cannot_delete_user"))
      return false
    end
  end
end
