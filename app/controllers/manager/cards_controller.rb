class Manager::CardsController < ApplicationController
  layout 'manager'
  before_action :authenticate_manager!
  before_action :check_manager_company
  before_action :set_user_and_company
  before_action :set_card

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to company_manager_users_path, notice: '更新完了'
    else
      render :edit
    end
  end

  private

    def set_user_and_company
      @company = Company.find(params[:company_id])
      @user = User.find(params[:user_id])
    end

    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:number)
    end

end