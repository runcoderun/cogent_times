class PivotalTracker::Base

  include HappyMapper

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def to_xml(options = {})
    return build_xml_for(self.class, options)
  end

  private
  
  def build_xml_for(tracker_class, options = {})
    get_instance = tracker_class.name.downcase.to_sym
    builder = Builder::XmlMarkup.new(options)
    builder.send(get_instance) do |instance|
      tracker_class.elements.each do |element_type|
        element = send(element_type.name)
        eval("instance.#{element_type.name}(\"#{element.to_s.gsub("\"", "\\\"")}\")") if element
      end
    end
  end

end
