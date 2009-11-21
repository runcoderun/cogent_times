# <activity>
#     <id type="integer">9178549</id>
#     <project>CodeYak</project>
#     <story>revisions counts don't add up</story>
#     <description>Benjamin Birnbaum added comment: &quot;We fixed the looping of revisions and am unable to replicate this bug.&quot;</description>
#     <author>Benjamin Birnbaum</author>
#     <when>11/17/2009 07:06 AM</when>
#   </activity>
  
class PivotalTracker::Activity < PivotalTracker::Base
  include HappyMapper
  element :id, Integer
  element :project, String
  element :story, String
  element :description, String
  element :author, String
  element :when, DateTime

  # def initialize(attributes = {})
  #   attributes.each do |key, value|
  #     send("#{key}=", value)
  #   end
  # end

  # def to_xml(options = {})
  #   builder = Builder::XmlMarkup.new(options)
  #   builder.note do |note|
  #     Note.elements.each do |element_type|
  #       element = send(element_type.name)
  #       eval("note.#{element_type.name}(\"#{element.to_s.gsub("\"", "\\\"")}\")") if element
  #     end
  #   end
  # end

  # def to_param
  #   id.to_s
  # end
end
