json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :date, :in_time, :out_time, :total_duration, :status
  json.url attendance_url(attendance, format: :json)
end
