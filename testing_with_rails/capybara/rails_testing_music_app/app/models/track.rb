# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  album_id   :integer          not null
#  ord        :integer          not null
#  lyrics     :text             not null
#  bonus      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates :title, presence: true
  validates :ord, presence: true, uniqueness: { scope: :album_id }
  validates :lyrics, presence: true
  validates :bonus, inclusion: { in: [true, false] }

  after_initialize :set_defaults

  belongs_to :album,
    class_name: 'Album',
    primary_key: :id,
    foreign_key: :album_id
  
  has_one :band,
    through: :album,
    source: :band

  has_many :notes,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: 'Note',
    dependent: :destroy

  def set_defaults
    self.bonus ||= false
  end
end
