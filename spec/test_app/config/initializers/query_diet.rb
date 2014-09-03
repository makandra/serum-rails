# Configure query_diet so it displays the number of database queries during development. 
# origin: RM
if defined?(QueryDiet)
  QueryDiet::Logger.bad_count = 12
  # QueryDiet::Logger.bad_time = 5000
end
