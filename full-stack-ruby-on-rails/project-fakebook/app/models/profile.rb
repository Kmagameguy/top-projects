class Profile < ApplicationRecord
  belongs_to :user

  def pretty_format_birthday
    birthday.strftime('%B %e, %Y')
  end

  def address
    "#{address1}#{address2.blank? ? '' : ' ' + address2}, #{city}, #{state}, #{zip}"
  end
end
