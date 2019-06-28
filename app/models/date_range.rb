class DateRange < Node
  validate :range_present?
  validate :range_order
  
  def includes?(date)
    (date.present? && (date_from.blank? || date >= date_from) && (date_to.blank? || date <= date_to))
  end

  private
  def range_present?
    if date_from.blank? && date_to.blank?
      errors.add(:date_from, "cannot be blank")
      errors.add(:date_to, "cannot be blank")
    end
  end

  def range_order
    if date_from.present? && date_to.present? && date_from > date_to
      errors.add(:date_to, "cannot be less than first value")
    end
  end
end
