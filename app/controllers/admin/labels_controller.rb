class Admin::LabelsController < ApplicationController
before_action :set_params, only: %i[edit update destroy]

  def index
    @labels = Label.all
    redirect_to admin_users_path
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_users_path, notice: "ラベルを追加しました。"
    else
      flash[:alert] = "追加できませんでした。"
      render :new
    end
  end

  def edit
  end

  def update
    @label.update(label_params)
    redirect_to admin_users_path, notice: "更新しました。"
  end

  def destroy
    @label.destroy
    redirect_to admin_users_path, notice: "ラベルを削除しました。"
  end

  private

  def set_params
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
