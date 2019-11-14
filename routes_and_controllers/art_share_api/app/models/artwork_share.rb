# == Schema Information
# 
# The artwork_shares table is a join table. Its whole purpose is to link a User 
# (the person viewing the artwork) with an Artwork.
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArtworkShare < ApplicationRecord
  # Ensure that a user cannot have a single Artwork shared with them more than 
  # once.
  validates :artwork_id, uniqueness: { scope: :viewer_id }

  # Connecting an ArtworkShare to a User
  belongs_to :viewer, 
    class_name: 'User',
    primary_key: :id,
    foreign_key: :viewer_id

  # Connecting an ArtworkShare to an Artwork  
  belongs_to :artwork,
    class_name: 'Artwork',
    primary_key: :id,
    foreign_key: :artwork_id
    
end
