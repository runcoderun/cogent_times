class EmployeesController < ApplicationController
  
  before_filter :find_employee, :only => %w(show update destroy)

  def index
    @employees = Employee.all
  end
  
  def new
    @employee = Employee.new
  end
  
  def create
    Employee.new(params[:employee]).save
    show_employees
  end

  def show
  end

  def update
    @employee.update_attributes(params[:employee])
    show_employees
  end

  def destroy
    @employee.destroy
    show_employees
  end

  private

  def find_employee
    @employee = Employee.get(params[:id])
  end

  def show_employees
    redirect_to(employees_path)
  end
  
end
