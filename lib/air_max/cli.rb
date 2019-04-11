class AirMax::CLI
    def start
        title = "A HISTORY IN AIR MAX".bold.yellow
        puts title.center(80)
        
        AirMax::Scraper.new.scrape_page

        am_intro   # show brief history of Air Max shoes, scraped from site
        menu            # display menu
    end

    def am_intro
        doc = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))
        info = wrap_long_string(doc.css("section.content p").text)
        puts info
    end

    def wrap_long_string(text, max_width = 60)
        # (text.length < max_width) ? text : text.scan(/.{1,#{max_width}}/).join("")
        (text.length < max_width) ? text : text.gsub(/(.{1, max_width})( +|$\n?)|(.{1,max_width})/, "\\1\\3\n")
    end

    def menu
        input = nil
        while input != "exit"
            puts "\nTo view a list of Air Max shoes type \'list\'.".yellow
            print "To quit, type \'exit\': ".yellow
            input = gets.strip.downcase
            if input.to_i.between?(1,27)
                am_list(input)
            elsif input == "exit"
                finished
            elsif input == "list"
                shoe_list
            else
                puts "Invalid input".blink.red + ", type list or exit.".red
                menu
            end
        end
    end

    def shoe_list
        puts "\nNike Air Max from 1978 - 2019".bold.yellow
        puts "------------------------------------".yellow
        @am_shoes = AirMax::Air.all
        @am_shoes.each.with_index(1) do |shoe, i|
            if i == 13 || i == 24
                puts "   #{i}. #{shoe.shoe_name}".yellow
            else
                puts "   #{i}. #{shoe.shoe_name}".yellow
            end
        end
        puts "------------------------------------".yellow
        print "\nTo view the history of a particular shoe, choose a number between 1 - 27.".yellow
    end

    def am_list(input)
        shoe_num = input.to_i - 1
        shoe_details = @am_shoes[shoe_num]
        if shoe_num == 13 || shoe_num == 24
            puts "\n\n#{shoe_details.shoe_name}".yellow
            puts "\n#{shoe_details.description}\n\n".yellow
        else
            puts "\n\n#{shoe_details.shoe_name}".yellow
            puts "\n#{shoe_details.description}\n\n".yellow
        end
    end

    def finished
        puts "\n\nThank you for viewing the Air Max History! \nHave a Nice Day!".bold.yellow
        exit
    end

end