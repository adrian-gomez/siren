class Reservation < ActiveRecord::Base

  # Validating emails is not an easy task and if the user needs to confirm it that seems like
  #  a sufficient validation.
  # See: http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
  validates_format_of :email, :with => /@/

  with_options :on => :update do |reservation|
    reservation.validate  :email_not_changed
    reservation.validates :first_name, :presence => true
    reservation.validates :last_name, :presence => true
    reservation.validates :phone_number, :presence => true,
                                         :numericality => { :only_integer => true }
  end

  private

  def email_not_changed
    if email_changed? && self.persisted?
      errors.add(:email, 'Change of email not allowed!')
    end
  end

end