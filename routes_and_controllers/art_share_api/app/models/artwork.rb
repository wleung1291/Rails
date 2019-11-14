# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true, uniqueness: true
  # Ensure a single user cannot have two artworks with the same title. On the 
  # other hand, two different users can have artworks with the same title.
  # :scope option allows you to specify one or more attributes that are 
  # used to limit the uniqueness check. Must then create a unique index on both 
  # columns in your database
  validates :title, uniqueness: {scope: :artist_id}

  # The association from Artwork to User
  belongs_to :artist,
    class_name: 'User',
    primary_key: :id, # user's id
    foreign_key: :artist_id # from artworks table
  
  # The association from Artwork to ArtworkShare
  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: 'ArtworkShare'

  # will return the set of users with whom an artwork has been shared.
  has_many :shared_viewers,
    through: :artwork_shares, # Artwork#artwork_shares association above
    source: :viewer # ArtworkShare#viewer associaiton

  # include dependent: :destroy because when an artwork is removed from the 
  # database, we don't want their associated comments to persist.
  has_many :comments,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: 'Comment',
    dependent: :destroy

  # call an association on artworks to get the users who have liked them.
  # Setting the :as option indicates that this is a polymorphic association
  has_many :likes, as: :likeable

  # class method that returns all of the artworks made by the user OR
  # shared with the user
  def self.artworks_for_user_id(user_id)
    #joins_cond = <<-SQL
    #  LEFT OUTER JOIN
    #    artwork_shares ON artworks.id = artwork_shares.artwork_id
    #SQL

    Artwork
      .left_outer_joins(:artwork_shares)
      .where("(artworks.artist_id = :user_id) OR 
        (artwork_shares.viewer_id = :user_id)", {user_id: user_id})
      .distinct
  end
end
