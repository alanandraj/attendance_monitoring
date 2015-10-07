class Employee < ActiveRecord::Base
  has_many :attendances

  validates :emp_id, :presence => true, :uniqueness => true
  validates :emp_name, :presence => true
end
