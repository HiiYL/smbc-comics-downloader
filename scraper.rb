require 'mechanize'
require 'colorize'

agent = Mechanize.new
page = agent.get("http://smbc-comics.com")
current_idx = page.search('//*[@id="buttonwidth"]/a[2]').attribute("href").text.split("?id=").last
current_idx = current_idx.to_i + 1
while current_idx > 0
	page = agent.get("http://www.smbc-comics.com/index.php?id=" + current_idx.to_s)
	page.search('//*[@id="comic"]')
	image = page.search('//*[@id="comic"]')
	image_name = current_idx.to_s + "_" + image.first.attributes["title"].text + ".png"
	if Dir[image_name].empty?
		agent.get(image.first.attributes["src"]).save( image_name )
		puts "create ".green + image_name
	else
		puts "identical ".blue + image_name
	end
	current_idx = current_idx - 1
end