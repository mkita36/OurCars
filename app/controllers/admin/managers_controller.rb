class Admin::ManagersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_company
  before_action :set_manager, only: %i(edit update destroy)

  def index
    @manager = @company.managers
  end

  def new
    @manager = @company.managers.build
  end

  def edit
  end

  def create
    @manager = @company.managers.build(manager_params)
    if @manager.save
      redirect_to admin_company_managers_path(@company), notice: '新規登録完了'
    else
      render :new
    end
  end

  def update
    if @manager.update(manager_params)
      redirect_to admin_company_managers_path, notice: '更新完了'
    else
      render :edit
    end
  end

  def destroy
    @manager.destroy
    redirect_to admin_company_managers_path, notice: '削除完了'
  end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_manager
      @manager = Manager.find(params[:id])
    end

    def manager_params
      params.require(:manager).permit(:manager_name, :email, :password, :password_confirmation)
    end
end