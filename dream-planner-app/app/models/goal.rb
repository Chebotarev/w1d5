class Goal < ActiveRecord::Base
  include Commentable
  validates :content, :status, :owner, :title, presence: true

  

  belongs_to(
    :owner,
    class_name: 'User',
    foreign_key: :owner_id,
    primary_key: :id
  )

end
