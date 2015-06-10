class Building < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness => { :scope => :address }
  validates :address, :presence => true
  validates :phone, :presence => true

  has_many :users
  has_many :posts
  has_many :signups

end
