include AutoHtml

class Micropost < ActiveRecord::Base
  belongs_to :user
  
  IMAGE_URL_REGEX = /\Ahttp:.*(jpeg|jpg|gif|png)\z/i
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  auto_html_for :content do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => false)
    vimeo(:width =>400, :height => 250, :autoplay => false)
    instagram
    google_map
    link :target => "_blank", :rel => "nofollow"
    twitter
    simple_format
  end
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

  private

    def find_image_url
      str = self.content
      self.content = auto_html(str) { simple_format; link(:target => 'blank') }
    end

end
