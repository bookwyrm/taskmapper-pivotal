require File.dirname(__FILE__) + '/pivotal/pivotal-api'

# Monkey patch for backward compatibility issue with type cast on xml response
class Hash
  class << self
    alias_method :from_xml_original, :from_xml

    def from_xml(xml)
      scrubbed = scrub_attributes(xml)
      from_xml_original(scrubbed)
    end

    def scrub_attributes(xml)
      xml.gsub(/<stories.*>/, "<stories type=\"array\">")
    end
  end
end

%w{ pivotal ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

