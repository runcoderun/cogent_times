class PivotalTracker::Task  < PivotalTracker::Base

  include HappyMapper

  element :id, Integer
  element :description, String
  element :position, Integer
  element :complete, Boolean
  element :created_at, DateTime

  # def to_xml(options = {})
  #   builder = Builder::XmlMarkup.new(options)
  #   builder.task do |task|
  #     Task.elements.each do |element_type|
  #       element = send(element_type.name)
  #       eval("task.#{element_type.name}(\"#{element.to_s.gsub("\"", "\\\"")}\")") if element
  #     end
  #   end
  # end

end
