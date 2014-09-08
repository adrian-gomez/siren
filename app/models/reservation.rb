class Reservation < ActiveRecord::Base

  MAX_RATING = 5

  has_and_belongs_to_many :amenities

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

  with_options :on => :rate do |reservation|
    reservation.validates :rating, :presence => true,
                          :numericality => { :only_integer => true,
                                             :greater_than_or_equal_to => 1,
                                             :less_than_or_equal_to => MAX_RATING }
  end

  validate  :rating_not_changed


  def confirmed?
    first_name.present? && last_name.present? && phone_number.present?
  end

  def rated?
    rating.present?
  end

  private

  def email_not_changed
    if email_changed? && self.persisted?
      errors.add(:email, 'Change of email not allowed!')
    end
  end

  def rating_not_changed
    if rated? && rating_was && rating_changed? && persisted?
      errors.add(:rating, 'Change of rating not allowed!')
    end
  end

end