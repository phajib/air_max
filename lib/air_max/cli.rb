# CLI Controller

class AirMax::CLI
    def start
        title = "A HISTORY IN AIR MAX".bold.red
        puts title.center(100)
        AirMax::Scraper.new.scrape_page

        brief_history   # shoe brief history of Air Max shoes, scraped from site
        menu            # display menu
        finished        # exit
    end

    def brief_history
        doc = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))
        info = wrap_long_string(doc.css("section.content p").text)
        puts info
    end

    def wrap_long_string(text,max_width = 50)
        (text.length < max_width) ?
          text :
          text.scan(/.{1,#{max_width}}/)#.join("")
    end

    def shoe_list
        puts "\n\nNike Air Max from 1978 - 2019\n\n"
        @am_shoes = AirMax::Air.all
        @am_shoes.each.with_index(1) do |shoe, i|
            if i == 13
                puts "#{i}. #{shoe.max96}"
            elsif i == 24
                puts "#{i}. #{shoe.zero}"
            else
                puts  "#{i}. ".light_blue + "#{shoe.shoe_name}".yellow
            end
        end
    end

    def menu
        input = nil
        print "\nType \'list\' to view all Air Max shoes or type \'exit\' to quit: "
        input = gets.strip.downcase
        while input != "exit"
            if  input == "list"
                am_list
            else
                puts "Input is invalid, type list or exit."
                menu
            end
        end
    end

    def am_list
        shoe_num = nil
        shoe_list
        print "\nTo view history of a particular shoe, type a number: "
        shoe_num = gets.strip

        if shoe_num.to_i.between?(0,27)
            shoe_details = @am_shoes[shoe_num.to_i - 1]
             puts "\n\n" + shoe_details.shoe_name + "\n\n" + shoe_details.description + "\n\n\n\n"
        else
            puts "\nInvalid input, select a number from above.\n\n\n\n"
            am_list
        end
    end

    def finished
        puts "\n\nThank you for viewing the Air Max History! \nHave a Nice Day!"
    end

end