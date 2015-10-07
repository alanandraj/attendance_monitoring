class EmployeeShow < Prawn::Document
  def initialize(employee)
    super(top_margin: 70)
    @employee = employee
    text "#{@employee.id}"
  end
end