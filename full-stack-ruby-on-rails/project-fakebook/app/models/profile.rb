class Profile < ApplicationRecord
  belongs_to :user

  def birthday
    return nil if read_attribute(:birthday).blank?
    read_attribute(:birthday).strftime('%m/%d/%y')
  end

  def address
    "#{address1}#{address2.blank? ? '' : ' ' + address2}, #{city}, #{state}, #{zip}"
  end
end
