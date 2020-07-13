class Manager::UsesController < ApplicationController
  layout 'manager'
  before_action :authenticate_manager!
  before_action :check_manager_company
  before_action :set_use, only: %i(edit update destroy)
  before_action :set_company_and_car

  def index
    @uses = @car.uses.order(created_at: :desc)
  end

  def new
    @use = @car.uses.build
  end

  def edit
  end

  def create
    @use = @car.uses.build(use_params)
    if @use.inspection_st == '車検依頼'
      @car.update(state: '車検中')
    else
      @car.update(state: '空車')
    end
    if @use.save
      if @use.id > @car.uses.order(:id).first.id
        @use.update(distance: @use.odometer - @car.uses.where("id < #{@use.id}").order(:id).last.odometer)
      else
        @use.update(distance: @use.odometer - @car.initial_odometer)
      end
      if @car.uses.where.not(refueling_amount: 0).count >=2
        @car.update(mileage: (@car.uses.where.not(refueling_amount: 0).order(:id).last.odometer - @car.uses.where.not(refueling_amount: 0).order(:id).last(2).first.odometer)/@car.uses.where.not(refueling_amount: 0).order(:id).last.refueling_amount)
      end
      redirect_to company_manager_car_uses_path(@company, @car), notice: '新規登録完了'
    else
      render :new
    end
  end

  def update
    if @use.update(use_params)
      if @use.inspection_st == '車検依頼'
        @car.update(state: '車検中')
      else
        @car.update(state: '空車')
      end
      if @use.id > @car.uses.order(:id).first.id
        @use.update(distance: @use.odometer - @car.uses.where("id < #{@use.id}").last.odometer)
      else
        @use.update(distance: @use.odometer - @car.initial_odometer)
      end
      if @car.uses.where.not(refueling_amount: 0).count >= 2
        @car.update(mileage: (@car.uses.where.not(refueling_amount: 0).order(:id).last.odometer - @car.uses.where.not(refueling_amount: 0).order(:id).last(2).first.odometer)/@car.uses.where.not(refueling_amount: 0).order(:id).last.refueling_amount)
      end
      redirect_to company_manager_car_uses_path(@company, @car), notice: '変更完了'
    else
      render :edit
    end
  end

  private
    def set_use
      @use = Use.find(params[:id])
    end

    def set_company_and_car
      @company = Company.find(params[:company_id])
      @car = Car.find(params[:car_id])
    end

    def use_params
      params.require(:use).permit(:use_day, :odometer, :destination, :refueling_amount, :wash, :oil_change, :self_inspection, :inspection_st, :user_id, :car_id)
    end
end
