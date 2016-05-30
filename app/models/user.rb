class User < ActiveRecord::Base
	has_secure_password
	has_many :articles, dependent: :destroy
	has_many :activities, dependent: :destroy

	validates_length_of :password, :minimum => 8 , :message => "密碼長度須大於8", on: :create
	validates_uniqueness_of :email, :message => "信箱已被使用", on: :create
	validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => "請輸入信箱"
	validates_presence_of :name , :message => "請填寫名稱"
	validates_presence_of :profile,:message => "請填寫自我介紹"
	mount_uploader :avatar, AvatarUploader
	attr_accessor :crop_x, :crop_y,:crop_w,:crop_h
	after_update :crop_avatar

	def crop_avatar
		avatar.recreate_versions! if crop_x.present?
	end
end
