class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :manager_name])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_companies_path
    when Manager
      company_manager_cars_path(Company.find(current_manager.company_id))
    when User
      company_status_index_path(Company.find(current_user.company_id))
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    elsif resource == :manager
      new_manager_session_path
    else
      new_user_session_path
    end
  end

  def check_manager_company
    if Company.last.id >= params[:company_id].to_i
      unless Company.find(params[:company_id]) === current_manager.company
        redirect_to destroy_manager_session_path
      end
    else
      redirect_to destroy_manager_session_path
    end
  end

  def check_user_company
    if Company.last.id >= params[:company_id].to_i
      unless Company.find(params[:company_id]) === current_user.company
        redirect_to destroy_user_session_path
      end
    else
      redirect_to destroy_user_session_path
    end
  end
end
