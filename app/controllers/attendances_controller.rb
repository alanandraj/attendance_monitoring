class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @attendances = Attendance.all
    respond_with(@attendances)
  end

  def show
    respond_with(@attendance)
  end

  def new
    @attendance = Attendance.new
    respond_with(@attendance)
  end

  def edit
  end

  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.save
    respond_with(@attendance)
  end

  def update
    @attendance.update(attendance_params)
    respond_with(@attendance)
  end

  def destroy
    @attendance.destroy
    respond_with(@attendance)
  end

   def view_attendance
     from_date = params[:fromdate]
     to_date = params[:todate]

     selected_employee =  params[:selected_employee]


     unless selected_employee.nil? or selected_employee == ""
       @emp_attendances = Attendance.joins(:employee).select([:id, :emp_id, :emp_name, :date, :in_time, :out_time, :total_duration, :status]).
           where("emp_name = ?", selected_employee).order(:date)
       @all_attendances = []
       params[:leave_or_all] = nil
     else
       @all_attendances = Attendance.joins(:employee).select([:id, :emp_id, :emp_name, :date, :in_time, :out_time, :total_duration, :status]).
           where("date >= ? and date <= ?",from_date, to_date).order(:date)
       @emp_attendances = []
     end

     @leave = []
     leave_or_all_val = params[:leave_or_all]

     if leave_or_all_val.nil?
       @leave = []
     elsif leave_or_all_val == "all"
       @all_attendances = Attendance.joins(:employee).select([:id, :emp_id, :emp_name, :date, :in_time, :out_time, :total_duration, :status]).order(:date)
     elsif leave_or_all_val == "leave"
       @leave = Attendance.joins(:employee).select([:id, :emp_id, :emp_name, :date]).where("status = 'A'").order(:date)
     end

     respond_to do |format|
       format.html
       format.pdf do
         pdf = Prawn::Document.new
         @leave.each do |rec|
           pdf.text "#{rec.emp_name}"
         end
         send_data pdf.render, filename: "Attendance.pdf",
             type: "application/pdf",
             disposition: "inline"

       end
     end

   end

  private
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:date, :in_time, :out_time, :total_duration, :status)
    end
end
