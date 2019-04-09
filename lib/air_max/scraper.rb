class AirMax::Scraper

    def scrape_page
        am_air = []
        page = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))
        page.css("section.content-image").each do |am|
            shoe_name = am.css("h3").text
            description = am.css("p").text
            am_air << {name: shoe_name, history: description}
            AirMax::Air.new(shoe_name, description)
        end
        am_air
    end


end