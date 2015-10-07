json.array!(@employees) do |employee|
  json.extract! employee, :id, :emp_id, :emp_name
  json.url employee_url(employee, format: :json)
end
