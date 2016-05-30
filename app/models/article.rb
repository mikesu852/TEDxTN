class Article < ActiveRecord::Base
	mount_uploader :thumb, ImageUploader
	belongs_to :user
	validates_length_of :summary, :maximum => 120 , :message => "摘要長度須小於120"
	validates_presence_of :title , :message => "請填寫標題"
	validates_presence_of :thumb , :message => "請上傳圖片"
	validates_presence_of :summary,:message => "請填寫摘要"
	acts_as_taggable
end
