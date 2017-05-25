class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :name, presence: true, length: {maximum: 50}
  

  has_many :transfers
  has_many :orders
  belongs_to :reffered, :class_name => 'User', foreign_key: 'reffered_by'
  has_many :refferences, :class_name => 'User', foreign_key: 'reffered_by'

  # def number_of_referred_users
  #   User.where(reffered_by: self.id).count
  # end

  scope :all_except, ->(user) { where.not(id: user) }

  protected
  def confirmation_required?
    false
  end

  # def user_level
  # 	u = self.refferences.count

  # 	if u < 10 
  # 		1
  # 	elsif u > 9 && u < 20
  # 		2
  # 	elsif u > 100 
  # 		10
  # 	else
  # 		(u / 10).to_i
  # 	end
  # end
end
