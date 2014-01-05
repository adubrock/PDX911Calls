json.array!(@calls) do |call|
  json.extract! call, :call_id, :call_type, :address, :agency, :latitude, :longitude, :call_last_updated, :zip
  json.url call_url(call, format: :json)
end