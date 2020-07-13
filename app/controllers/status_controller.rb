class StatusController < ApplicationController
  layout 'user'
  before_action :authenticate_user!
  before_action :check_user_company
  before_action :set_company
  before_action :set_car, except: [:index]

  def index
    @cars = @company.cars.order(created_at: :desc)
  end

  def ride
    @car.update(state: "#{current_user.user_name}が乗車中")
    redirect_to company_status_index_path(@company), notice: 'お気をつけてご乗車ください'
  end

  def no_ride
    @car.update(state: '空車')
    redirect_to company_status_index_path(@company), notice: '乗車取り消し完了'
  end

  private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_car
      @car = Car.find(params[:car_id])
    end
end
