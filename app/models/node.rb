class Node < ActiveRecord::Base
  
  validates :title, presence: true
  # validates :content, presence: true
  validates :position, presence: true
  validates :parent, presence: true
  
end