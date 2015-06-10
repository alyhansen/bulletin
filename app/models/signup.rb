class Signup < ActiveRecord::Base
  validates :building_id, :presence => true

  belongs_to :building
end
