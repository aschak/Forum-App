class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  validates :title, uniqueness: true
  
  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
end
