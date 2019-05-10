class Project < ApplicationRecord
	has_many :user_projects, dependent: :destroy
	has_many :users, through: :user_projects
	has_many :bugs, dependent: :destroy

  validates :title, presence: true

end
