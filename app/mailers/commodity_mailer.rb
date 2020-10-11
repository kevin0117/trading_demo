class CommodityMailer < ApplicationMailer
  default from: 'postmaster@chienhao.tw'

  def deal_closed_email(user_object)
    @user = user_object
    
    @url = 'http://localhost:3000/login'
    mail(to: @user.email, subject: "委託單成交")
  end

  def notify_deal_email(admin, starter, closer)
    @admin = admin
    @starter = starter
    @closer = closer

    @url = 'http://localhost:3000/login'

    mail(to: @admin.email, subject: "委託單成交")
  end
end
