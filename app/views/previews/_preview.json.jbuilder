json.extract! preview, :id, :created_at, :updated_at
# json.extract! preview, :id, :created_at, :updated_at, :str_input, :json_output

json.url preview_url(preview, format: :json)
