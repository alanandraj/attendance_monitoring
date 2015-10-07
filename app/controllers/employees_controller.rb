class EmployeesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: 'New Employee added successfully'
    else
      render action: "new"
    end
  end

  def show
    @employee = Employee.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = EmployeeShow.new(@employee)
        send_data pdf.render, filename: "employee_#{@employee.emp_id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(employee_params)
      redirect_to @employee, notice: 'Updated Successfully'
    else
      render action: "edit"
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to admins_index_path
  end

  private
  def employee_params
    params.require(:employee).permit(:emp_id, :emp_name)
  end

end
