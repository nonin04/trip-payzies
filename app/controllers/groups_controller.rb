class GroupsController < ApplicationController
  before_action :set_group, only: [ :show, :edit, :update, :destroy ]

  def index
    @groups = current_user.groups
  end

  def show
  end

  def new
    @group = current_user.groups.new
    @members_for_form = build_members_for_form([])
  end

  def create
    # グループとメンバー一括作成
    @group = current_user.groups.build(group_params)
    members_name = member_params

    Group.transaction do
      @group.save!
      members_name.each do |mn|
        next if mn[:name].blank?
        @group.members.create!(mn)
      end
    end
    flash[:notice] = I18n.t("flash.group.success.create")
    redirect_to group_path(@group)
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = I18n.t("flash.group.failed.create")
    @members_for_form = build_members_for_form(member_params)
    render :new, status: :unprocessable_entity
  end


  def edit
    @members_for_form = build_members_for_form(@group.members.map { |gm| { name: gm.name } })
  end

  def update
    Group.transaction do
      @group.update!(group_params)
      @group.members.destroy_all
        member_params.each do |mn|
          next if mn[:name].blank?
          @group.members.create!(mn)
        end
      end
    flash[:notice] = I18n.t("flash.group.success.update")
    redirect_to group_path(@group)

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = I18n.t("flash.group.failed.update")
    @members_for_form = build_members_for_form(member_params)
    render :edit, status: :unprocessable_entity
  end


  def destroy
    @group.destroy
      redirect_to groups_path, notice: I18n.t("flash.group.success.delete")
  end

  def members_for_group
    group_id = params[:group_id]
    selected_group = current_user.groups.find_by(id: group_id)
    render json: { names: selected_group.members.pluck(:name) }
  end


  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def build_members_for_form(input_members)
    members = input_members.map { |m| @group.members.build(m) }
    (10 - members.size).times { members << @group.members.build }
    members
  end

  def group_params
    params.require(:group).permit(:name, :icon, :remove_icon)
  end

  def member_params
    params.require(:members).map do |m|
      m.permit(:name)
    end
  end
end
