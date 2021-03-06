# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

    # create movie in the database
    Movie.create(movie)
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  # the page source code contains string e1 before string e2
  page.body.should =~ /#{e1}.*#{e2}/m

  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  # split the ratings to the array
  rating_list = rating_list.split(', ')

  if uncheck then
    # uncheck each rating
    rating_list.each { |rating|
      uncheck("ratings_#{rating}")
    }
  else
    # check each rating
    rating_list.each { |rating|
      check("ratings_#{rating}")
    }
  end

  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table

  # count the number of movies in the database
  number_of_movies = Movie.count

  # count number of rows in the movies table displayed
  number_of_rows = page.all('table#movies tbody tr').count

  # those numbers should be the same
  number_of_rows.should == number_of_movies
  #fail "Unimplemented"
end
