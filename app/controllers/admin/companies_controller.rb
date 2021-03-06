class Admin::CompaniesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_company, only: %i(edit update destroy)

  def index
    @company = Company.all
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to admin_companies_path, notice: '新規登録完了'
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to admin_companies_path, notice: '更新完了'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to admin_companies_path, notice: '削除完了'
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name)
    end
end