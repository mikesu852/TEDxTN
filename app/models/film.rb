class Film < ActiveRecord::Base
  	belongs_to :user
    has_many :films, dependent: :destroy
    validates_length_of :summary, :maximum => 150 , :message => "摘要長度須小於150"
    validates_presence_of :title , :message => "請填寫標題"
    validates_presence_of :summary,:message => "請填寫摘要"

    def self.search(keyword,category,event)
      where("title LIKE ? AND category LIKE ? AND event LIKE ?", "%#{keyword}%", "%#{category}%", "%#{event}%")
    end
end
