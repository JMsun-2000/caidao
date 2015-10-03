class Notifier < ActionMailer::Base
  default from: "jmsun_2000@hotmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @greeting = "Hi"
    @order = order
    mail to: "jmsun_2000@hotmail.com"
   # mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped
    @greeting = "Hi"

    mail to: "jmsun_2000@hotmail.com"
  end
end
