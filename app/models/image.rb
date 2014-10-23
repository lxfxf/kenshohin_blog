class Image < ActiveRecord::Base
  belongs_to :blog
  validates :blog_id, presence: true
  has_attached_file :image, styles: { medium: "300*300", thumb: "100*100 "},
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/ ]
end
