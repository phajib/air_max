class AirMax::CLI
    def start
        title = "A HISTORY IN AIR MAX".bold.yellow
        puts title.center(80)
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

    def wrap_long_string(text,max_width = 75)
        (text.length < max_width) ?
          text :
          text.scan(/.{1,#{max_width}}/)#.join("")
    end

    def menu
        input = nil
        print "\nTo view a list of Air Max shoes type \'list\' or type \'exit\' to quit: ".yellow
        input = gets.strip.downcase
        case input
        when "exit"
            finished
        when "list"
            am_list
        else
            puts "Invalid input".blink.red + ", type list or exit.".red
            menu
        end
    end

    def shoe_list
        puts "\nNike Air Max from 1978 - 2019".bold.yellow
        puts "------------------------------------".yellow
        @am_shoes = AirMax::Air.all
        @am_shoes.each.with_index(1) do |shoe, i|
            if i == 13
                puts "#{i}. #{shoe.max96}".yellow
            elsif i == 24
                puts "#{i}. #{shoe.zero}".yellow
            else
                puts  "#{i}. #{shoe.shoe_name}".yellow
            end
        end
        puts "------------------------------------".yellow
    end

    def am_list
        shoe_list
        puts "\nTo view the history of a particular shoe, select a number between 1 - 27.".yellow
        puts "To return to the menu type \'menu\'.".yellow
        print "To quit, type \'exit\': ".yellow
        input = gets.strip
        shoe_num = input.to_i - 1
        # binding.pry
        case input
        # if shoe_num.to_i.between?(0,27)
        when shoe_num.between?(1,27)
            # if index.between?(0,27)
            shoe_details = @am_shoes[shoe_num]
            if shoe_num == 13
                puts "\n\n#{shoe_details.shoe_name}.yellow"
                puts "\n#{shoe_details.max96}\n\n.yellow"
            elsif shoe_num == 24
                puts "\n\n#{shoe_details.shoe_name}.yellow"
                puts "\n#{shoe_details.zero}\n\n.yellow"
            else
                puts "\n\n#{shoe_details.shoe_name}".yellow
                puts "\n#{shoe_details.description}\n\n".yellow
            end
        # elsif shoe_num == "menu"
        #     menu
        # elsif shoe_num == "exit"
        #     finished
        when "menu"
            menu
        when "exit"
            finished
        else
            puts "\nInvalid input".blink.red + ", select a number between 1-27.\n".red
            am_list
        end
    end

    def finished
        puts "\n\nThank you for viewing the Air Max History! \nHave a Nice Day!".bold.yellow
        exit
    end

end