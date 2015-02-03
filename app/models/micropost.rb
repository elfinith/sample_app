class Micropost < ActiveRecord::Base
  belongs_to :user
  before_save :find_image_url
  IMAGE_URL_REGEX = /\Ahttp:.*(jpeg|jpg|gif|png)\z/i
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

  private

    def find_image_url
      str = self.content
      self.content = "<img src='" + str + "'>" if !!(IMAGE_URL_REGEX =~ str)
    end

end
