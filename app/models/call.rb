require 'open-uri'

class Call < ActiveRecord::Base
  def self.import_from_xml_uri(address)
    doc = Nokogiri::XML(open(address))
    
    doc.search('entry').each do |entry|
      entry.search('title').each do |title|
        call_type, address = title.text.split(/ at /)
        Call.create!(call_type: call_type, address: address)
      end
    end
  end
end
