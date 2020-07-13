class Manager::InspectionsController < ApplicationController
  layout 'manager'
  before_action :authenticate_manager!
  before_action :check_manager_company
  before_action :set_inspection, only: %i(edit update destroy)
  before_action :set_company_and_car

  def index
    @inspections = @car.inspections.order(created_at: :desc)
  end

  def new
    @inspection = @car.inspections.build
  end

  def edit
  end

  def create
    @inspection = @car.inspections.build(inspection_params)
    if @inspection.save
      redirect_to company_manager_car_inspections_path(@company, @car), notice: '新規登録完了'
    else
      render :new
    end
  end

  def update
    if @inspection.update(inspection_params)
      redirect_to company_manager_car_inspections_path(@company, @car), notice: '更新完了'
    else
      render :edit
    end
  end

  def destroy
    @inspection.destroy
    redirect_to company_manager_car_inspections_path(@company, @car), notice: '削除完了'
  end

  private
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def set_company_and_car
      @company = current_manager.company
      @car = Car.find(params[:car_id])
    end

    def inspection_params
      params.require(:inspection).permit(:start_day, :end_day, :fee, :limit, :inspection_memo, :car_id)
    end
end
