module GroupsHelper

  def file_name(group)
    if group.icon.present?
      File.basename(group.icon.identifier)
    end
  end
end
