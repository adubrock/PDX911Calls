require 'open-uri'

class Call < ActiveRecord::Base
  def self.import_from_xml_uri(uri)
    doc = Nokogiri::XML(open(uri))
    doc.search('entry').each do |entry|
      call_id = parse_call_id(entry)
      call_type = parse_call_type(entry)
      address = parse_address(entry)
      unless exists?(call_id: call_id)
        Call.create!(call_id: call_id, call_type: call_type, address: address)
      end
    end
  end

  def self.parse_call_id(entry)
    call_id = ""
    entry.search('id').each do |id|
      trash, data = id.text.split(/incidents\//)
      call_id << data
    end
    call_id
  end

  def self.parse_call_type(entry)
    call_type = ""
    entry.search('title').each do |title|
      data, trash = title.text.split(/ at /)
      call_type << data
    end
    call_type
  end

  def self.parse_address(entry)
    address = ""
    entry.search('title').each do |title|
      trash, data = title.text.split(/ at /)
      address << data
    end
    address
  end
end
