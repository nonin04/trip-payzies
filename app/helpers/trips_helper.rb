module TripsHelper

  
  
  
  # for_trip_card

  def trip_card_style(mode)
    if [:index, :group].include?(mode)
      'shadow-primary'
    else
      'dark:!bg-white'
    end
  end

  def show_arrow_icon?(mode)
    [:index, :group].include?(mode)
  end

  def can_edit_delete?(mode)
    [:show].include?(mode)
  end

  def display_group_info?(mode)
    Rails.logger.debug "mode = #{mode.inspect}"
    [:index, :show, :share, :result].include?(mode)
  end

  def group_title_color(mode)
    if [:index].include?(mode)
      ''
    else
      'dark:!text-neutral-600'
    end
  end


  def settlement_status_options
    Trip.settlement_statuses.map do |key, value|
      [t("activerecord.attributes.trip.settlement_status.#{key}"), value]
    end
  end

end
