class Manager::MemosController < ApplicationController
  layout 'manager'
  before_action :authenticate_manager!
  before_action :check_manager_company
  before_action :set_memo, only: %i(edit update destroy)
  before_action :set_company_and_car

  def index
    @memos = @car.memos.order(created_at: :desc)
  end

  def new
    @memo = @car.memos.build
  end

  def edit
  end

  def create
    @memo = @car.memos.build(memo_params)
    if @memo.save
      redirect_to company_manager_car_memos_path(@company, @car), notice: '新規登録完了'
    else
      render :new
    end
  end

  def update
    if @memo.update(memo_params)
      redirect_to company_manager_car_memos_path(@company, @car), notice: '更新完了'
    else
      render :edit
    end
  end

  def destroy
    @memo.destroy
    redirect_to company_manager_car_memos_path(@company, @car), notice: '削除完了'
  end

  private
    def set_memo
      @memo = Memo.find(params[:id])
    end

    def set_company_and_car
      @company = current_manager.company
      @car = Car.find(params[:car_id])
    end

    def memo_params
      params.require(:memo).permit(:content, :memo_day, :car_id)
    end
end
