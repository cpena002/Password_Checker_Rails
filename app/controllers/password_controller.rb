class PasswordController < ApplicationController

  def check
    # Set attempts to zero.
    cookies[:attempts] = 0 unless !cookies[:attempts].nil?
    # Add one to attempts. Remember, everything inside cookies gets turn into a string. 
    cookies[:attempts] = cookies[:attempts].to_i+1


    # If the parameter :user_id doesn't have a key, set instance variables to empty string.
    if !params.has_key?(:user_id)
        @valid_id = ""
        @valid_password = ""
    end

    # If the parameter :user_id has a key && is not blank/empty, store the :user_id parameter in the @user_id variable.

    if params.has_key?(:user_id) && !params[:user_id].strip.empty?
      @user_id = params[:user_id]

      # Set conditions for user id. If this conditions are/aren't met, change value of instance variable @valid_id to the indicated string.
      if @user_id.length >= 6 && !@user_id.include?("#") && !@user_id.include?("$")
        @valid_id = "User ID is acceptable."
      else
        @valid_id = "Invalid User ID. Try Again."
      end
    end

    # If the parameter :user_password has a key && is not blank/empty, store the :user_password parameter in the @user_password variable.
    if params.has_key?(:user_password) && !params[:user_password].strip.empty?
      @user_password = params[:user_password]

      # Set conditions for user password. If this conditions are/aren't met, change value of instance variable @valid_password to the indicated string.
      if @user_password.length >= 6 && (@user_password.include?("#") || @user_password.include?("$"))
        @valid_password = "Password is acceptable."
      else
        @valid_password = "Invalid Password. Try Again"
      end
    end

    # Warn user he has one more try if cookies[:attempts] reaches 4.
    if cookies[:attempts].to_i == 4
      @credential_tries = "You have one more try"
    end

    # Inform user he ran out of attempts if cookies[:attempts] reaches 5.
    if cookies[:attempts].to_i == 5
      @credential_tries = "You ran out of attempts"

      # Reset cookies[:attempts] to zero.
      cookies[:attempts] = 0
    end
  end
end
