class Manager::UsersController < ApplicationController
  layout 'manager'
  before_action :authenticate_manager!
  before_action :check_manager_company
  before_action :set_company
  before_action :set_user, only: %i(edit update destroy)

  def index
    @user = @company.users
  end

  def new
    @user = @company.users.build
  end

  def edit
  end

  def create
    @user = @company.users.build(user_params)
    if @user.save
      card = @user.build_card(number: 0)
      card.save
      redirect_to company_manager_users_path(@company), notice: '新規登録完了'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to company_manager_users_path, notice: '更新完了'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    if @user.errors.present?
      redirect_to company_manager_users_path, notice: "#{@user.errors.messages[:base].first}。"
    else
      redirect_to company_manager_users_path, notice: '削除完了'
    end
  end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

end