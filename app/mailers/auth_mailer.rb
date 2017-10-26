class AuthMailer < ApplicationMailer
  def success_auth(email, user_agent)
    @user_agent = user_agent
    mail(
      to: email,
      subject: 'Authentication has been successful'
    )
  end

  def failed_auth(email, user_agent)
    @user_agent = user_agent
    mail(
      to: email,
      subject: 'Authentication has been failed'
    )
  end
end
