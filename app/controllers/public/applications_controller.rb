class Public::ApplicationsController < ApplicationController

def confirm
  @recruitment=Recruitment.find(params[:id])
end

def create
  @
  if @application.save
      redirect_to complete_application_path
  end
end

def complete
end

def history
end

def show  
end

def cancel
end

def destroy
end

end

private
  

