class List < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy

  validates_presence_of :title
end
