require 'open-uri'
require 'date'

class Call < ActiveRecord::Base
  default_scope -> { order('updated_at DESC') }
  validates_uniqueness_of :call_id

  def self.import_from_xml_uri(uri)
    doc = Nokogiri::XML(open(uri)).remove_namespaces!
    doc.search('entry').each do |entry|
      call_id = XmlParser.parse_call_id(entry)
      call_type = XmlParser.parse_call_type(entry)
      address = XmlParser.parse_address(entry)
      agency = XmlParser.parse_agency(entry)
      updated_at = XmlParser.parse_call_updated_at(entry)
      latitude = XmlParser.parse_latitude(entry)
      longitude = XmlParser.parse_longitude(entry)

      Call.create(call_id: call_id,
                  call_type: call_type,
                  address: address,
                  agency: agency,
                  updated_at: updated_at,
                  latitude: latitude,
                  longitude: longitude)
    end
  end

  class XmlParser
    def self.parse_call_id(entry)
      entry.at_css('id').text[/\w+$/]
    end

    def self.parse_call_type(entry)
      entry.at_css('title').text.split(' at ').first
    end

    def self.parse_address(entry)
      entry.at_css('title').text.split(' at ').last
    end

    def self.parse_agency(entry)
      entry.at_css('summary').text[/\[(.*?) \#/m, 1]
    end

    def self.parse_call_updated_at(entry)
      entry.at_css('updated').text
    end

    def self.parse_latitude(entry)
      entry.at_css('point').text.split(' ').first
    end

    def self.parse_longitude(entry)
      entry.at_css('point').text.split(' ').last
    end
  end
end
