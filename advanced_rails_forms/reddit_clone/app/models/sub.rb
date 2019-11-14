# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  belongs_to :moderator,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :moderator_id

  has_many :post,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: 'Post'

  has_many :post_subs,
    inverse_of: :sub,
    dependent: :destroy

  has_many :posts,
    through: :post_subs,
    source: :post
end
