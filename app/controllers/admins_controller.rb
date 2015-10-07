require 'csv'
class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employees = Employee.all
    all_data = Attendance.all
    csvfile = params[:file]

    @csv_file_data_array = Array.new

    unless csvfile.nil?
      CSV.foreach(csvfile.path, headers: true) do |row|
      @csv_file_data_array << row
    end

    end

    @csv_file_data_array.each do |csv_data|
      date_val = csv_data[0]
      employee_id_val = csv_data[1]
      in_time_val = csv_data[2]
      out_time_val = csv_data[3]

      if in_time_val.nil? or out_time_val.nil?
        total_duration_val = ""
        status_val = "A"
      else
        diff_val = Time.diff(Time.parse(out_time_val.to_s), Time.parse(in_time_val.to_s), '%y, %d and %h:%m:%s')
        total_duration_val = diff_val[:diff]
        status_val = "P"
      end

      if all_data.empty?
        Attendance.create(:date => date_val, :employee_id => employee_id_val, :in_time => in_time_val,
                          :out_time => out_time_val, :total_duration => total_duration_val, :status => status_val)
        @str_msg = true
      else

      all_data.each do |rec_data|

        if rec_data.date == Date.parse(date_val) and rec_data.employee_id == employee_id_val.to_i
          @flag = true
          @rec_id = rec_data.id
        end
      end

      if @flag
        update_data = Attendance.find(@rec_id)
        update_data.update_attributes(:in_time => in_time_val, :out_time => out_time_val,
                                      :total_duration => total_duration_val, :status => status_val)
        @str_msg = true
      else
        Attendance.create(:date => date_val, :employee_id => employee_id_val, :in_time => in_time_val,
                          :out_time => out_time_val, :total_duration => total_duration_val, :status => status_val)
        @str_msg = true
      end
      @flag = false
      end
    end


end

end
