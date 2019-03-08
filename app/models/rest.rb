class Rest < ApplicationRecord
  has_many :foods, dependent: :destroy
  validates_presence_of :name
end
