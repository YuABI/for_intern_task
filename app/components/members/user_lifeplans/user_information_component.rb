# frozen_string_literal: true

class Members::UserLifeplans::UserInformationComponent < Members::BaseComponent
  attr_reader :user_lifeplan_decorator, :user_lifeplan_yearly_blance, :user, :address

  def initialize(**args)
    super(**args)

    @user_lifeplan_decorator = args[:user_lifeplan_decorator]
    @user_lifeplan_yearly_blance = args[:user_lifeplan_yearly_blance]
    @user = @user_lifeplan_decorator.user
    @address = @user.addresses.find_by(address_type: 'user')
  end

  def full_address
    return '' if address.blank?

    text = ''
    text += address.pref if address.pref.present?
    text += " #{address.city}" if address.city.present?
    text += " #{address.address1}" if address.city.present?
    text += " #{address.address2}" if address.city.present?
  end

  def duration_of_feeding_period
    ( Date.today - user_lifeplan_decorator.created_at.to_date ).to_i
  end

  def duration_of_deadline
    365 - duration_of_feeding_period
  end

  def calcurate_age(year)
    return '' if user.birthday.blank? || year.blank?

    year - user.birthday.year
  end

  def pension_start_year
    user_lifeplan_yearly_blance.pension_incomes.order(:payment_start_year).first&.payment_start_year
  end

  def elderly_facility_start_year
    p user_lifeplan_yearly_blance.elderly_facility_expenses.order(:payment_start_year)
    user_lifeplan_yearly_blance.elderly_facility_expenses.order(:payment_start_year).first&.payment_start_year
  end

  def nursing_care_start_year
  end

end
