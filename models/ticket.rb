require_relative("../db/sql_runner")
require_relative('customer')
require_relative('film')

class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id
  

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING *;"
    ticket = SqlRunner.run(sql)
    @id = ticket[0]['id'].to_i
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
    customer_hash = SqlRunner.run(sql).first
    return Customer.new(customer_hash)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = #{@film_id}"
    film_hash = SqlRunner.run(sql).first
    return Film.new(film_hash)
  end

  # def paid_ticket
  #   sql = "SELECT (c.funds - f.price) = (#{@funds} - #{@price}) 
  #         FROM customers as c
  #         JOIN films as f 
  #         ON #{@id} = f.customer_id"
  #         SqlRunner.run(sql)
  # end

 def self.all()
   sql = "SELECT * FROM tickets"
   tickets = SqlRunner.run(sql)
   result = tickets.map { |ticket| Ticket.new(ticket) }
   return result
 end

 def self.delete_all() 
   sql = "DELETE FROM tickets"
   SqlRunner.run(sql)
 end

end

