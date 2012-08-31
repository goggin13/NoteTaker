class Note < ActiveRecord::Base
  attr_accessible :body, :course_id, :title, :day
  
  validates_presence_of :course_id
  validates_presence_of :title
  validates_presence_of :day
  
  belongs_to :course
  
  def formatted_day
    day.strftime('%m/%d')
  end
  
end
