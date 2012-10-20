class Movie < ActiveRecord::Base
	def self.ratings
		['G','PG','PG-13','R','NC-17']
		#Movie.find_by_sql("SELECT DISTINCT rating FROM movies")
	end
end
