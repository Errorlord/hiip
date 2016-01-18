class Structure < ActiveRecord::Base
  
  validates :title, presence: true
  validates :description, presence: true
  validates :position, presence: true
  
end