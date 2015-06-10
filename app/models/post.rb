class Post < ActiveRecord::Base

  validates :subject, :presence => true
  validates :content, :presence => true

  belongs_to :user
  belongs_to :building
  has_many :comments

end
