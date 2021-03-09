class License < ApplicationRecord
    validates :paid_till, presence: true
end
