module ProfileHelper
  NO_INFO = 'No information provided.'.freeze

  def format_date(date)
    date.blank? ? NO_INFO : date.strftime('%B %e, %Y')
  end

  def format_email(email)
    email.blank? ? NO_INFO : (mail_to email)
  end

  def format_phone(phone_number)
    phone_number.blank? ? NO_INFO : (phone_to phone_number)
  end

  def format_attribute(attribute)
    attribute.blank? ? NO_INFO : attribute
  end
end
