class Cat < ApplicationRecord
  include Toyable
  # has_many :toys, as: :toyable
end
