
class Bug < ApplicationRecord
  mount_uploader :screenshot, ImageUploader

  belongs_to :user
  belongs_to :project

  validates :title, presence: true
  validates :bug_status, :bug_type, presence: true
  validates :screenshot, allow_blank: true, format: { with: %r{.(gif|png)\Z}i, message: 'must be GIF or PNG image.' }


  validates_uniqueness_of :title, scope: [:project_id]

end
