class UserMailer < ApplicationMailer

  def account_activation(user)
    admins = User.where(admin: true)
    @user = user
    admins.each do |admin|
      mail to: admin.email, subject: "New Account Activation Request"
    end
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
end