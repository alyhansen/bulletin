class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  belongs_to :building

  has_attached_file :avatar, :styles => { :medium => "90x90#", :thumb => "45x45#" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    # default_url => "/images/:style/missing.png"

  def admin?
    role == "Admin"
  end
end
