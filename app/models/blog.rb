class Blog < ActiveRecord::Base


  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  default_scope -> { order('created_at DESC')}

  # has_attached_file :image, styles: { medium: "300*300", thumb: "100*100 "},
  #                   default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


end
