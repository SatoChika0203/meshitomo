class Admin::ApplicationsController < ApplicationController
  def history
    @user=User.find(params[:user_id])
    @applications=Application.where(applicant_id: params[:user_id])
    @applications_page = Application.all.page(params[:page]).per(5)
  end
end
