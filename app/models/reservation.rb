class Reservation < ActiveRecord::Base

  # Validating emails is not an easy task and if the user needs to confirm it that seems like
  #  a sufficient validation.
  # See: http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
  validates_format_of :email, :with => /@/

end