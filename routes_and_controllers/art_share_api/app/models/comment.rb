# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  artwork_id :integer          not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :artwork,
    class_name: 'Artwork',
    primary_key: :id,
    foreign_key: :artwork_id

  # call an association on comments to get the users who have liked them.
  # Setting the :as option indicates that this is a polymorphic association
  has_many :likes, as: :likeable

end
