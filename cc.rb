require 'open-uri'
require 'nokogiri'
require 'sqlite3'

doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_national_capitals_and_largest_cities_by_country"))

doc.xpath('//table[@class = "wikitable"]').each_with_index.map do |node, i|
	#next if ((i+1) % 3 == 0)
	next if (i > 0)
	#puts node
	puts i
	puts "ashu"
	z = 1
	candc = Array.new
	node.xpath('./tr/td').each_with_index.map do |cc, x|
		next if ((x+1) % 3 == 0)
		#puts x
		if (((x+3)%3) ==0)
			#print z
			#print " - Country: "
			#print cc.text
			#print cc.text
			#print "  Capital:"
			#puts cc[x+1].text 
			#candc.push z
			candc.push cc.text
			z += 1
		else
			#print "  Capital: "
			#puts cc.text
			candc.push cc.text
			#next
		end
		#puts cc.text
		#puts x
	end

	#node.children.each_with_index.map do |firsttable, i|
	#	firsttable.xpath('/tr/td').each_with_index.map do |cc, x|
	#		puts cc
	#		puts x
	#	end
		#puts i
		#puts row
	#end
	#if (i%2 ==0)
	#	print "Country: "
	#else
	#	print "Capital: "
	#end
	#puts node.text

	#puts candc

	db = SQLite3::Database.open "geoIQ.sqlite"

	rows = db.execute("select * from ZCOUNTRYINFO") 

	rows.each do |row|
		puts row
	end

	db.execute("DELETE FROM ZCOUNTRYINFO")

	rows = db.execute("select * from ZCOUNTRYINFO") 

	rows.each do |row|
		puts row
	end

#country = 'Mexico'
#capital = 'Mexico City'

#puts country

#db.execute "INSERT INTO ZCOUNTRYINFO(ZCAPITAL, ZCOUNTRYNAME) VALUES ('Paris', 'France')"

#stm = db.prepare "INSERT INTO ZCOUNTRYINFO(ZCAPITAL, ZCOUNTRYNAME) VALUES ('?', '?')"
#stm.bind_params = capital, country
#stm.execute

	candc.each_with_index.map do |node, i|
		#next if ((i+1)%3 == 0)
		next if ((i%2)>0)
		#print i
		#print node
		print "Country: "
		print candc[i]
		print "  Capital: "
		puts candc[i+1]
		db.execute "INSERT INTO ZCOUNTRYINFO(ZCAPITAL, ZCOUNTRYNAME) VALUES (?, ?)" , candc[i+1], candc[i]
	end

	#puts candc

	db.close if db

end



