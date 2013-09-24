class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  # prevents mass assignment on other fields not in this list
  attr_accessible :email, :password, :password_confirmation, :remember_me
  belongs_to :organization
  
  def can_edit? org
    admin? || (!org.nil? && organization == org)
  end
  def active_for_authentication?
      super && charity_admin?
  end 

  def inactive_message
    if !charity_admin?
      :not_approved
    else
      super # Use whatever other message
    end
  end
end
