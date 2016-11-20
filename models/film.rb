require_relative("../db/sql_runner")
require_relative("customer")

class Film 

  attr_accessor :title, :price
  attr_reader :id
   
  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *;"
    film = SqlRunner.run(sql)
    @id = film[0]['id'].to_i
  end

  def customers()
    sql = "SELECT c.*, t.* FROM customers c
          INNER JOIN tickets t
          ON c.id = t.customer_id
          WHERE t.film_id = #{@id};"
    customers = Customer.get_many(sql)
    return customers
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new( film ) }
    return result
  end

end
