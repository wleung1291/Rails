# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string           not null
#

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  
  # Association between User and Artwork
  has_many :artworks,
    primary_key: :id, # user's id
    foreign_key: :artist_id, 
    class_name: 'Artwork',
    dependent: :destroy 
  
  # Association between User and ArtworkShares
  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :viewer_id,
    class_name: 'ArtworkShare',
    dependent: :destroy

  # Will return the set of artworks that have been shared with that user 
  # (not the set of artworks that a user has shared with others).
  has_many :shared_artworks,
    through: :artwork_shares,  # User#artwork_shares association above
    source: :artwork # ArtworkShare#artwork association

  # include dependent: :destroy because when a user is removed from the 
  # database, we don't want their associated comments to persist.
  has_many :comments,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Comment',
    dependent: :destroy

  # Call associations on a user and return their liked comments and artworks. 
  has_many :likes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Like'

  # The :source_type option specifies the source association type for a has_one 
  # :through association that proceeds through a polymorphic association.
  has_many :liked_comments,
    through: :likes,
    source: :likeable,
    source_type: 'Comment'

  has_many :liked_artworks,
    through: :likes,
    source: :likeable,
    source_type: 'Artwork'
end
