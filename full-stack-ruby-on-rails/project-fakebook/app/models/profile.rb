class Profile < ApplicationRecord
  belongs_to :user

  def full_address
    [address1, address2, city, state, zip].compact.join(', ')
  end
end
