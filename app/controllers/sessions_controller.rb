require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @view = SessionsView.new
    @employee_repository = employee_repository
  end

  def sign_in
    # 1. Perguntar o username
    username = @view.ask_username
    # 2. Perguntar o password
    password = @view.ask_password

    # 3. Encontrar um employee pelo username informado no passo 1
    employee = @employee_repository.find_by_username(username)

    # 4. Verificar se encontrou um employee e o password é igual ao informado no passo 2
    if employee && employee.password == password
      @view.welcome(employee.username)
      # retorna o employee
      employee
    else
      # informa erro
      @view.wrong_credentials
      # tentar novamente
      sign_in
    end
  end
end
