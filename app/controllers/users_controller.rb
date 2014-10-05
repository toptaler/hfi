class UsersController < ApplicationController
  # We have introduced some convoluted logic in order to get email addess from twitter users
  # see http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/#completing-the-signup-process

  def show_finish_signup

  end

  def finish_signup
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to :root, notice: 'Your profile was successfully updated.'
    else
      flash[:error] = @user.errors.empty? ? "Error" : @user.errors.full_messages.to_sentence if is_navigational_format?
      redirect_to finish_signup_path(@user) and return
    end
  end

  private

  def user_params
    accessible = [:email]
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end