require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
  end

  def add
    # 1. Listar e pegar o meal selecionado
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @orders_view.ask_index
    meal = meals[index]

    # 2. Listar e pegar o customer selecionado
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @orders_view.ask_index
    customer = customers[index]

    # 3. Listar e pegar o rider selecionado
    riders = @employee_repository.all_riders
    @orders_view.display_riders(riders)
    index = @orders_view.ask_index
    employee = riders[index]

    # 4. Instanciar o order
    new_order = Order.new(meal: meal, customer: customer, employee: employee)

    # 5. Adicionar o order ao repositório de order
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)

  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    # 1. Listar as orders não entregues do employee
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @orders_view.display(orders)

    # 2. Perguntar o index
    index = @orders_view.ask_index

    # 3. Marcar a order selecionada como entregue
    order = orders[index]
    order.deliver!

    # 4. salvar as orders
    @order_repository.save_csv
  end
end
