class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects  
  has_many :bugs

  def name_and_type
	"#{name} (#{user_type})"
  end

end
