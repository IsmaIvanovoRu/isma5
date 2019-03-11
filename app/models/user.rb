class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  
  validates :login, :presence => true, 
            :length => { :maximum => 50 }, 
            :uniqueness => true
  validates :password, :confirmation => true,
            :length => { :minimum => 8 },
            :presence => true
  validates :password_confirmation, :presence => true
  
  has_and_belongs_to_many :groups
  has_one :profile
  
  def admin?
    self.groups.where(administrator: true).count > 0
  end
  
  def moderator?
    self.groups.where(moderator: true).count > 0
  end
  
  def writer?
    self.groups.where(writer: true).count > 0
  end
end
