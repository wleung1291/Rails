# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer          not null
#  live       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  validates :title, presence: true, uniqueness: {scope: :band_id}
  validates :year, presence: true, numericality: {minimum: 1900, maximum: 9000}
  # can't use presence validation with boolean field
  validates :live, inclusion: { in: [true, false] } 
  validates :band, presence: true

  # callback will be called whenever an Active Record object is instantiated, 
  # either by directly using new or when a record is loaded from the database. 
  after_initialize :set_defaults  # set default for live column

  belongs_to :band,
    class_name: 'Band',
    primary_key: :id,
    foreign_key: :band_id

  has_many :tracks,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: 'Track',
    dependent: :destroy

  def set_defaults
    self.live ||= false
  end
end
