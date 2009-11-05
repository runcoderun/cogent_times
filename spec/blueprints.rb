Sham.name  { Faker::Name.name }

ProjectCategory.blueprint do
  name { Sham.name }
end

Person.blueprint do
  first_name  { Sham.name }
  surname     { Sham.name }
end

Project.blueprint do
  name  { Sham.name }
  project_category { ProjectCategory.make }
end

WorkPeriod.blueprint do
  person  { Person.make }
  project  { Project.make }
  date  { Date.today }
  hours  { 9.6 }
end
