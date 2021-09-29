require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @view = CustomersView.new
    @customer_repository = customer_repository
  end

  def add
    # 1. Perguntar o nome do customer
    name = @view.ask_name
    # 2. Perguntar o preço do customer
    address = @view.ask_address
    # 3. Instanciar um objeto customer
    customer = Customer.new(name: name, address: address)
    # 4. Adicionar o customer ao repositório de customer
    @customer_repository.create(customer)
  end

  def list
    # 1. Pegar todos os customers do repositório de customer
    customers = @customer_repository.all

    # 2. Listar todos os customers
    @view.display(customers)
  end
end
