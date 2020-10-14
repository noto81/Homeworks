class UsersController < ApplicationController


def show
   render :show
end


def new
    @user = User.new
    render :new
end

def create
    @user = User.new(user_params)
    if @user.save
        session[:session_token] = @user.reset_session_token!
        redirect_to users_url
    else
        flash[:errors] = @user.errors.full_messages
        render :new
    end
    
end


def user_params
    params.require(:user).permit(:email,:password)
end



end
