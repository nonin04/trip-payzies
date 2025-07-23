module ApplicationHelper
  def display_menu?
    unless devise_controller? || controller_path.start_with?("share/")
      true
    else
      false
    end
  end

  def shared_user?
    controller_path.start_with?("share/")
  end
end
