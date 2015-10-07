class AdminMailer < ActionMailer::Base
  default from: "a.anandraj02@gmail.com"

  def signup_confirmation(admin)
    @admin = admin
    mail(to: @admin.email, :subject => "Confirmation Mail")
  end
end
