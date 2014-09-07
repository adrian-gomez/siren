module DateHelper

  def safe_l(date, *args)
    if date
      l(date, *args)
    else
      t('application.not_available')
    end
  end

end