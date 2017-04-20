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

  def sales_report(email)
    @orders = Order
    @items = Item
    @users = User
    mail(to: email, subject: 'Pickle progress report')
  end
end
