# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = ["black", "white", "orange", "brown"]

  validates :birth_date, presence: true
  # inclusion validates that the attributes' values are included in a given set. 
  # In fact, this set can be any enumerable object.
  validates :color, inclusion: COLORS, presence: true
  validates :name, presence: true
  validates :sex, inclusion: ["M", "F"], presence: true

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'CatRentalRequest',
    dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
  
end
