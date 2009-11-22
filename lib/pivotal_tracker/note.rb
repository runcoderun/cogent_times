class PivotalTracker::Note < PivotalTracker::Base

  include HappyMapper

  element :id, Integer
  element :text, String
  element :author, String
  element :noted_at, DateTime
  has_one :story, Story

  # def to_xml(options = {})
  #   builder = Builder::XmlMarkup.new(options)
  #   builder.note do |note|
  #     Note.elements.each do |element_type|
  #       element = send(element_type.name)
  #       eval("note.#{element_type.name}(\"#{element.to_s.gsub("\"", "\\\"")}\")") if element
  #     end
  #   end
  # end

end
