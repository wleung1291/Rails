# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

STATUS_STATES = ["PENDING", "APPROVED", "DENIED"]

class CatRentalRequest < ApplicationRecord
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: STATUS_STATES, presence: true

  
  belongs_to :cat,
    class_name: 'Cat',
    primary_key: :id,
    foreign_key: :cat_id
  
  after_initialize :assign_pending_status


  # get all the CatRentalRequests that overlap with the one we are trying to validate
  def overlapping_requests
    # gets all the rental requests except for this rental
    # gets all the rentals with the cat we want to validate
    # gets the rental that overlaps the dates
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where.not('start_date > :end_date OR end_date < :start_date', 
        start_date: start_date, end_date: end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end
  
  def does_not_overlap_approved_request
    if !overlapping_approved_requests.empty?
      errors[:base] << 'Request overlaps'
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_pending_requests.each do |req|
        req.update!(status: "DENIED")
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  private

  def assign_pending_status
    self.status ||= "PENDING"
  end

end
