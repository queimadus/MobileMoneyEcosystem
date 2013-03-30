class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
         
  #before_save:ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me#, :name
  # attr_accessible :title, :body

  validates :email, :presence => true, :uniqueness => true
  #validates :name, :uniqueness => true
  #validates :password, :presence => true

  has_one :client
  has_one :merchant

  def is_client?
    client != nil
  end

  def is_merchant?
    merchant != nil
  end
end
