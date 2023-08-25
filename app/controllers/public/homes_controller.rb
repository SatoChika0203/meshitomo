class Public::HomesController < ApplicationController
  def top
    if user_signed_in?
      redirect_to recruitments_path
    end
    
    if admin_signed_in?
      redirect_to admin_recruitments_path
    end
  end
end
