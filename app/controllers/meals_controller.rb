require_relative '../views/meals_view'

class MealsController

  def initialize(meal_repository)
    @view = MealsView.new
    @meal_repository = meal_repository
  end

  def add
    # 1. Perguntar o nome do meal
    name = @view.ask_name
    # 2. Perguntar o preço do meal
    price = @view.ask_price
    # 3. Instanciar um objeto meal
    meal = Meal.new(name: name, price: price)
    # 4. Adicionar o meal ao repositório de meal
    @meal_repository.create(meal)
  end

  def list
    # 1. Pegar todos os meals do repositório de meal
    meals = @meal_repository.all

    # 2. Listar todos os meals
    @view.display(meals)
  end
end