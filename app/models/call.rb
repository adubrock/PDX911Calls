require 'open-uri'

class Call < ActiveRecord::Base
  default_scope -> { order('call_last_updated DESC') }

  def self.import_from_xml_uri(uri)
    doc = Nokogiri::XML(open(uri)).remove_namespaces!
    doc.search('entry').each do |entry|
      call_id = XmlParser.parse_call_id(entry)
      call_type = XmlParser.parse_call_type(entry)
      address = XmlParser.parse_address(entry)
      agency = XmlParser.parse_agency(entry)
      call_last_updated = XmlParser.parse_call_last_updated(entry) 
      latitude = XmlParser.parse_latitude(entry)
      longitude = XmlParser.parse_longitude(entry)
      unless exists?(call_id: call_id)
        Call.create!(call_id: call_id, 
                     call_type: call_type,
                     address: address,
                     agency: agency,
                     call_last_updated: call_last_updated,
                     latitude: latitude,
                     longitude: longitude )
      end
    end
  end

  class XmlParser
    def self.parse_call_id(entry)
      entry.at_css('id').text[/\w+$/]
    end

    def self.parse_call_type(entry)
      entry.at_css('title').text.split(" at ").first
    end

    def self.parse_address(entry)
      entry.at_css('title').text.split(" at ").last
    end

    def self.parse_agency(entry)
      entry.at_css('summary').text[/\[(.*?) \#/m, 1]
    end

    def self.parse_call_last_updated(entry)
      entry.at_css('updated').text   
      # data = entry.at_css('updated').text
      # call_last_updated = Time.zone.parse(data)
    end

    # def self.parse_call_last_updated(entry)
    #   start_string = /Last Updated:&lt;\/dt&gt;\s*&lt;dd&gt;/
    #   end_string = /&lt;/
    #   entry.at_css('content').to_s[/#{start_string}(.*?)#{end_string}/m, 1]
    # end

    def self.parse_latitude(entry)
      entry.at_css('point').text.split(" ").first
    end

    def self.parse_longitude(entry)
      entry.at_css('point').text.split(" ").last
    end
  end
end
