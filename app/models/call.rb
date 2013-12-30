require 'open-uri'

class Call < ActiveRecord::Base
  def self.import_from_xml_uri(uri)
    doc = Nokogiri::XML(open(uri))
    
    doc.search('entry').each do |entry|
      
      call_info = []
      
      entry.search('id').each do |id|
        trash, call_id = id.text.split(/incidents\//)
        call_info << call_id
      end

      entry.search('title').each do |title|
        call_type, address = title.text.split(/ at /)
        call_info << call_type
        call_info << address
      end

      Call.create!(call_id: call_info[0], call_type: call_info[1], address: call_info[2])
    end
  end
end
