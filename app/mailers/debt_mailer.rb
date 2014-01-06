class DebtMailer < ActionMailer::Base
  default from: "iou.bill.confirmation@gmail.com"

  def payment_confirmation(email, debt)
    @debt = debt

    mail(:to => email, :subject => "Payment #{debt.id} Details from IOU")
  end
end
