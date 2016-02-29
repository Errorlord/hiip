class Path < ActiveRecord::Base
  
  validates :title, presence: true
  validates :content, presence: true
  
  def FormalPrint
    "#{title} #{content}"
  end
end