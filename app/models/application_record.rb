class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def price_format(number = price)
    "$%.2f" % number
  end
end
