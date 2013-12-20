json.array!(@calls) do |call|
  json.extract! call, :call_id, :call_type, :address, :agency, :latitude, :longitude, :last_updated
  json.url call_url(call, format: :json)
end