class Blog < ActiveRecord::Base


  belongs_to :user
  has_many :images
  validates :user_id, presence: true
  validates :content, presence: true
  default_scope -> { order('created_at DESC')}




end
