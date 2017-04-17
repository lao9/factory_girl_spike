class OrderMailer < ApplicationMailer

  def new_order(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Your order has been placed')
  end

  def update(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Your order has been updated')
  end
end
