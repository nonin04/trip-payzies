module GroupsHelper
  def file_name(group)
    if group.icon.present?
      File.basename(group.icon.identifier)
    end
  end


  def icon_url(group)
    group.icon&.url || "group-icon.jpg"
  end
end
