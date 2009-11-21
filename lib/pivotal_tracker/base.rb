class PivotalTracker::Base

  include HappyMapper

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def to_xml(options = {})
    return build_xml_for(options)
  end

  private
  
  def build_xml_for(options = {})
    builder = Builder::XmlMarkup.new(options)
    builder.send(tag_name) do |object_tag|
      create_value_tags_in(object_tag)
    end
  end

  def create_value_tags_in(object_tag)
    self.class.elements.each do |element_type|
      create_value_tag(object_tag, element_type)
    end
  end
  
  def create_value_tag(object_tag, element_type)
    element_name = element_type.name
    value = self.send(element_name)
    eval("object_tag.#{element_name}(\"#{value.to_s.gsub("\"", "\\\"")}\")") if value
  end

  def tag_name
    class_name_without_module.downcase.to_sym
  end
  
  def class_name_without_module
    /([^:]+$)/.match(self.class.name)[0]
  end
end
