class Call < ActiveRecord::Base
  def self.create_from_xml(file)
    Call.create!(call_type: "PERSON CONTACT (86)",  address: "19600 BLOCK OF NE GLISAN ST, GRESHAM, OR")
    Call.create!(call_type: "TRAFFIC STOP",         address: "SE 80TH AVE / SE GLADSTONE ST, PORTLAND, OR")
    Call.create!(call_type: "WARRANT",              address: "19100 BLOCK OF E BURNSIDE ST, GRESHAM, OR")
  end
end
