require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'storefront/store.sqlite3'
)


class User < ActiveRecord::Base
  has_many :orders
  has_many :addresses
end

class Item < ActiveRecord::Base
  has_many :orders
end

class Order < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
end

class Address < ActiveRecord::Base
  belongs_to :user
end



#Q1)
puts User.count

#Q2)
puts Item.order(price: :desc).limit(5).pluck(:title, :price)

#Q3)
categories = Item.where("category LIKE '%Books%'")
puts categories.order(price: :asc).limit(1).pluck(:title, :price)

#Q4)
  #A1 =
print Address.joins(:user).where("street = '6439 Zetta Hills'").pluck(:first_name, :last_name)

  #A2 =
puts  User.joins(:addresses).where("last_name = 'Little'").pluck(:street)

#Q5)
Address.joins(:user).where("last_name = 'Mitchell'").pluck(:id)
Address.update(41, street: '12263 Jake Crossing',city: 'New York' , state: 'NY' , zip: 10108)
puts Address.where("id = '41' ").pluck(:city, :state, :zip)

#Q6)
puts Item.where("category LIKE '%Tools%'").sum(:price)

#Q7)
puts Order.sum(:quantity)

#Q8)
puts Item.where("category LIKE '%Books%'").joins(:orders).sum("orders.quantity * items.price")

#Q9)
User.create(first_name: "David", last_name:"Justice")
puts User.where("id = 51").pluck(:first_name, :last_name)
Order.create(user_id: 51, item_id: 5, quantity: 10, created_at: "2017-01-18 10:00:00")
puts  Order.where("id = 378").pluck(:id, :quantity, :created_at)









