class UserMailer < ApplicationMailer

  def account_activation(user, admin)
    @user = user
    mail to: admin.email, subject: "New Account Activation Request"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
end