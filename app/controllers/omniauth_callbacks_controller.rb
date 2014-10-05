class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      set_flash_message(:notice, :failure, :kind => "Facebook") if is_navigational_format?
      redirect_to new_user_session_path and return
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      set_flash_message(:error,  @user.errors.empty? ? "Error" : @user.errors.full_messages.to_sentence, :kind => "Twitter") if is_navigational_format?
      redirect_to new_user_session_path and return
    end
  end


  def after_sign_in_path_for(resource)
    #this is called by OmniauthCallbacksController in sign_in_and_redirect
    #since twitter does not provide an email address, for new twitter users we want to redirect to users#show_finish_signup
    #resource will be user
    if resource.email_verified?
      super resource
    else
      show_finish_signup_path(resource)
    end
  end

end