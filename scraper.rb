require 'open-uri'
require 'nokogiri'
 
PAGE_URL = "http://pdadb.net/m/index.php?m=specs&id="
 
File.open("data.txt", 'w') do |file|
  (0..9835).each do |count|
    page = Nokogiri::HTML(open(PAGE_URL + count.to_s))
 
    header = page.css("h2")
    title = header.text.sub "Specifications", ""
    title.strip!
 
    data = page.css("tr")
 
    date = ""
    resolution = ""
    data.each{ |chr|
      if chr.text["Display Resolution:"] then
        var = chr.text.sub "Display Resolution:", ""
        date = var.strip
      elsif chr.text["Release Date:"] then
        var = chr.text.sub "Release Date:", ""
        resolution = var.strip
      end
    }
 
    file.puts "#{count}, #{title}, #{date}, #{resolution}"
    sleep(0.3)
  end
end
