class EmployerMailer < ApplicationMailer
  
  def send_password_link(employer)
    @employer = employer
    mail(to: @employer.email, subject: "Update password")
  end

end
