class Ticket < ActiveRecord::Base
  attr_accessible :address, :email, :name, :phone, :seat, :surname
end
