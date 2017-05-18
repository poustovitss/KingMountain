class Transfer < ApplicationRecord
  belongs_to :user
  belongs_to :bank
end
