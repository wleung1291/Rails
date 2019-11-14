# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, presence: { message: 'must have at least one sub' }
  
  belongs_to :sub,
    class_name: 'Sub',
    primary_key: :id,
    foreign_key: :sub_id

  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  has_many :post_subs,
    inverse_of: :post,
    dependent: :destroy

  # Post#subs association gives a method, Post#sub_ids=, which will 
  # automatically create/destroy the necessary entries in the PostSub join 
  # table. Recall that Rails will call a setter method for each attribute that 
  # you assign in Post.new or Post#update, so if one of the keys in our 
  # attributes hash is sub_ids, Rails will automatically call Post#sub_ids=
  has_many :subs,
    through: :post_subs,
    source: :sub


end
