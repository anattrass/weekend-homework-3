require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'M Shadows', 'funds' => 100 })
customer2 = Customer.new({ 'name' => 'Lars Ulrich', 'funds' => 85 })
customer3 = Customer.new({ 'name' => 'Corey Taylor', 'funds' => 150 })

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({ 'title' => 'Anvil! The Story of Anvil', 'price' => 15 })
film2 = Film.new({ 'title' => 'School of Rock', 'price' => 15 })
film3 = Film.new({ 'title' => 'This is Spinal Tap', 'price' => 15 })

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket2 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id })
ticket3 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })

ticket1.save()
ticket2.save()
ticket3.save()

customer1.funds = 85

customer1.update()

customers = Customer.all()
films = Film.all()
tickets = Ticket.all()


binding.pry
nil