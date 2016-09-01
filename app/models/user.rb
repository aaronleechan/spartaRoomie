class User < ActiveRecord::Base

    before_create :confirmation_token

    has_many :posts, dependent: :destroy
    has_many :text_post, dependent: :destroy
    has_many :image_posts, dependent: :destroy
    
	has_many :friends, -> { where({status: "accepted"})}, class_name: :Friendship
	has_many :requested_friends,  -> { where({status: "requested"})}, class_name: :Friendship, foreign_key: :user_id, dependent: :destroy
	has_many :pending_friends,  -> { where({status: "pending"})}, class_name: :Friendship, foreign_key: :user_id, dependent: :destroy
	has_many :friendships, :dependent => :destroy
	has_many :images

# avatar is profile picture 
    mount_uploader :avatar, PictureUploader
   
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :firstName, presence: true
    validates :lastName, presence: true  
    validates_format_of :email, :with => /\A([^@\s]+)@(sjsu.edu)\z/i


    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(:validate => false)
    end

    private
    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
end
