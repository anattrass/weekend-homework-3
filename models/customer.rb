require_relative("../db/sql_runner")
require_relative('film')

class Customer
  
  attr_accessor :name, :funds
  attr_reader :id
  
  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *;"
    customer = SqlRunner.run(sql)
    @id = customer[0]['id'].to_i
  end

  def films()
    sql = "SELECT f.*, t.* FROM films f
          INNER JOIN tickets t
          ON f.id = t.film_id
          WHERE t.customer_id = #{@id};"
    films = Film.get_many(sql)
    return films
  end

  def update
    return unless @id
    sql = "UPDATE customers SET (name, funds) = 
          ('#{@name}', #{@funds})
          WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

end