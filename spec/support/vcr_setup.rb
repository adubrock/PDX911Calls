VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.ignore_request do |request|
    URI(request.uri).host == 'maps.googleapis.com'
  end
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
end
