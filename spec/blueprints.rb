Sham.name  { Faker::Name.name }

Employee.blueprint do
  first_name  { Sham.name }
  surname     { Sham.name }
end

Person.blueprint do
  first_name  { Sham.name }
  surname     { Sham.name }
end

Project.blueprint do
  name  { Sham.name }
end
