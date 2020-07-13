class Manager::CarsController < ApplicationController
  layout 'manager'
  before_action :authenticate_manager!
  before_action :check_manager_company
  before_action :set_car, only: %i(show edit update destroy)
  before_action :set_company

  def index
    @cars = @company.cars.order(created_at: :desc)
  end

  def show
  end

  def monthly_report
    @cars = @company.cars.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.xlsx {
        @range_start = Time.zone.local(params[:range]["range(1i)"].to_i, params[:range]["range(2i)"].to_i, params[:range]["range(3i)"].to_i)
        @range_end = @range_start + 1.month - 1.day
        response.headers['Content-Disposition'] = 'attachment; filename="運転月報"' + '.xlsx'
      }
    end
  end

  def half_period_report
    @cars = @company.cars.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.xlsx {
        @range_start = Time.zone.local(params[:range]["range(1i)"].to_i, params[:range]["range(2i)"].to_i, params[:range]["range(3i)"].to_i) - 5.month
        @range_end = @range_start + 6.month - 1.day
        response.headers['Content-Disposition'] = 'attachment; filename="運転月報集計表"' + '.xlsx'
      }
    end
  end

  def new
    @car = @company.cars.build
  end

  def edit
  end

  def create
    @car = @company.cars.build(car_params)
    if @car.save
      redirect_to company_manager_car_path(@company, @car), notice: '登録完了'
    else
      render :new
    end
  end

  def update
    if @car.update(car_params)
      redirect_to company_manager_car_path(@company, @car), notice: '編集完了'
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    redirect_to company_manager_cars_url, notice: '削除完了'
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def set_company
      @company = Company.find(params[:company_id])
    end

    def car_params
      params.require(:car).permit(:car_name, :region, :number, :purchase_day, :borrower, :parking, :tank, :oil_frequency, :initial_odometer, :initial_mileage, :state, :company_id)
    end
end
