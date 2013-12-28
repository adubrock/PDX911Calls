class Call < ActiveRecord::Base
  def self.create_from_xml(file)
    f = File.open(file)
    doc = Nokogiri::XML(f)
    f.close

    doc.search('entry').each do |entry|
      entry.search('title').each do |title|
        new_entry = title.to_s.split(/ at /)
        new_entry.map! { |element| element.gsub("<title>","")}
        new_entry.map! { |element| element.gsub("</title>","")}

        Call.create!(call_type: new_entry[0], address: new_entry[1])
      end
    end
  end
end
