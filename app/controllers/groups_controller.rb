class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def show

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @group.destroy
      redirect_to groups_path, notice: "グループを一件削除しました"
  end



  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end
end
