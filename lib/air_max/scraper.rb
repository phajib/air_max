class AirMax::Scraper

    def scrape_page
        am_air = []
        page = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))
        page.css("section.content-image").each.with_index(1) do |am, i|
            if i == 13
                max96 = page.css("section.content-image span")[0].text
            elsif i == 24
                zero = page.css("section.content-image span")[1].text
            else
                shoe_name = am.css("h3").text
                description = am.css("p").text
            end
            am_air << {name: shoe_name, name1: max96, name2: zero, history: description}
            AirMax::Air.new(shoe_name, description, max96, zero)
        end
        am_air
    end


end