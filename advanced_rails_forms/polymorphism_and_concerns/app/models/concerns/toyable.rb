module Toyable
  extend ActiveSupport::Concern

  included do
    has_many :toys,
      as: :toyable
  end

  # find or create a toy whose name matches the argument. 
  # Next it should add this toy to self's toys
  def receive_toy(name)
    # find_or_create_by, Finds the first record with the given attributes, 
    # or creates a record with the attributes if one is not found
    self.toys.find_or_create_by(name: name)
  end
end