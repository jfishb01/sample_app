class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  has_attached_file :pdf,
    :url  => "/assets/products/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
  validates_attachment :pdf, :presence => true,
    :size => { :in => 0..10.megabytes }
  validates_attachment_content_type :pdf,
    :content_type => /(image\/(png|gif|jpeg))|(application\/pdf)/,
    :message => 'only (png/gif/jpeg/pdf) files'

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
