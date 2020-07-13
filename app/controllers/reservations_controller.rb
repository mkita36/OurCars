class ReservationsController < ApplicationController
  layout 'user'
  before_action :authenticate_user!
  before_action :check_user_company
  before_action :set_company_and_car
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = @car.reservations
  end

  def new
    @reservation = @car.reservations.build
  end

  def create
    @reservation = @car.reservations.build(reservation_params)
    if @reservation.save
      redirect_to company_car_reservations_path(@company, @car), notice: '新規登録完了'
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to company_car_reservations_path(@company, @car), notice: '削除完了'
  end

  private

    def set_company_and_car
      @company = Company.find(params[:company_id])
      @car = Car.find(params[:car_id])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:reservation_day, :user_id, :car_id)
    end
end
