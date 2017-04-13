class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def price_format(price = price)
    "%.2f" % price
  end
end
