class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def show

  end

  def new
    @group = Group.new
    10.times { @group.members.build }
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

    flash[:notice] = "作成しました。"
    redirect_to group_path(@group)

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join(", ")
    filled_members_count = members_name.count { |m| m[:name].present? }
    (10 - filled_members_count).times { @group.members.build }
    render :new, status: :unprocessable_entity
  end


  def edit
  end

  def update
  end

  def destroy
    @group.destroy
      redirect_to groups_path, notice: "グループを一件削除しました"
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


  def group_params
    params.require(:group).permit(:name)
  end

  def member_params
    params.require(:members).map do |m|
      m.permit(:name) 
    end
  end

end
