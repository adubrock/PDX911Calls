require 'open-uri'

class Call < ActiveRecord::Base
 # geocoded_by :address
 # after_validation :geocode

  def self.import_from_xml_uri(uri)
    doc = Nokogiri::XML(open(uri))
    doc.search('entry').each do |entry|
      call_id = parse_call_id(entry)
      call_type = parse_call_type(entry)
      address = parse_address(entry)
      agency = parse_agency(entry)
      call_last_updated = parse_call_last_updated(entry) 
      latitude = parse_latitude(entry).to_f
      unless exists?(call_id: call_id)
        Call.create!(call_id: call_id, 
                     call_type: call_type,
                     address: address,
                     agency: agency,
                     call_last_updated: call_last_updated,
                     latitude: latitude )
      end
    end
  end

  def self.parse_call_id(entry)
    call_id = ""
    entry.search('id').each do |id|
      trash, call_id = id.text.split(/incidents\//)
    end
    call_id
  end

  def self.parse_call_type(entry)
    call_type = ""
    entry.search('title').each do |title|
      call_type, trash = title.text.split(/ at /)
    end
    call_type
  end

  def self.parse_address(entry)
    address = ""
    entry.search('title').each do |title|
      trash, address = title.text.split(/ at /)
    end
    address
  end

  def self.parse_agency(entry)
    agency = ""
    entry.search('summary').each do |summary|
      trash, data = summary.text.split(/\[/)
      agency, trash = data.split(/ #/)
    end
    agency
  end

  def self.parse_call_last_updated(entry)
    call_last_updated = ""
    entry.search('content').each do |content|
      trash, data = content.to_s.split(/Last Updated:&lt;\/dt&gt;\s*&lt;dd&gt;/)
      call_last_updated, trash = data.split(/&lt;/)
    end
    call_last_updated
  end

  def self.parse_latitude(entry)
  latitude = ""
    entry.search('updated').each do |coordinates|
      latitude, data = coordinates.text.split(/\s/)


      # latitude, data = coordinates.text.split(/\s/)

    # entry.search('updated').each do |coordinates|
    #   trash, latitude = coordinates.to_s.split(/-/)

      #latitude, longitude = coordinates.to_f.split(/\s/)
    end
    latitude
  end
end
