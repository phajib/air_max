class AirMax::Scraper

    def scrape_page
        am_air = []
        page = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))
        page.css("section.content-image").each.with_index(1) do |am, i|
            if i == 13 || i == 24
                shoe_name = am.css("span").text
                description = am.css("p").text
            else
                shoe_name = am.css("h3").text
                description = am.css("p").text
            end

            am_air << {name: shoe_name, history: description}
            AirMax::Air.new(shoe_name, description)
        end
        am_air
    end


end