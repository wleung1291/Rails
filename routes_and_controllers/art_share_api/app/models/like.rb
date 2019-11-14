# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  user_id       :integer
#  likeable_type :string
#  likeable_id   :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }

  # With polymorphic associations, a model can belong to more than one other 
  # model, on a single association.  For example, you might have a like 
  # model that belongs to either a comment model or an artwork model.  
  belongs_to :likeable, polymorphic: true
  
  belongs_to :user,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

end
