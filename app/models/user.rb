class User < ApplicationRecord
  FREQUENCIES = %w(daily weekly monthly)

  validates :frequency,
    inclusion: {
      in: FREQUENCIES,
      message: "%{value} is not a valid frequency."
    }
end
