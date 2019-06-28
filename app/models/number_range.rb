class NumberRange < Node
  validate :range_present?
  validate :range_order
  
  def includes?(value)
    (value.present? && (number_from.blank? || value.to_f >= number_from) && (number_to.blank? || value.to_f <= number_to))
  end

  private
  def range_present?
    if number_from.blank? && number_to.blank?
      errors.add(:number_from, "cannot be blank")
      errors.add(:number_to, "cannot be blank")
    end
  end

  def range_order
    if number_from.present? && number_to.present? && number_from.to_f > number_to.to_f
      errors.add(:number_to, "cannot be less than first value")
    end
  end
end
