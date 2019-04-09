# CLI Controller

class AirMax::CLI
    def start
        title = "A HISTORY IN AIR MAX"
        puts title.center(100)

        AirMax::Scraper.new.scrape_page

        # shoe brief history of Air Max shoes, scraped from site
        brief_history
        puts "\n"

        # display menu
        menu
        # list all shoes
        # ask for user input
        # display shoe and history of shoe

        # exit
        finished
    end

    def brief_history
        doc = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))

        puts doc.css("section.content p").text
    end

    def shoe_list
        @am_shoes = AirMax::Air.all
        @am_shoes.each.with_index(1) do |shoe, i|
            puts "#{i}. #{shoe.shoe_name}"
        end
    end

    def menu
        input = nil
        while input != "exit"
            print "\nType \'list\' to view all Air Max shoes or type \'exit\' to quit: "
            input = gets.strip.downcase

            if  input == "list"
                am_list
                # Ask user to view a particular shoe
            else
                puts "Input is invalid, type list or exit."
            end
        end
    end

    def am_list
        input = nil
        while input != "exit"
            shoe_list
            print "\nWould you like to read about a particular shoe? (Y/N): \n"
            input = gets.strip.upcase
            while input != "N" || input != "exit"
                if input == "Y"
                    print "Please select a number: "
                    shoe_num = gets.strip
                    index = shoe_num.to_i - 1
                    
                    if shoe_num.to_i.between?(0,27)#@am_shoes.length)
                        shoe_details = @am_shoes[index]
                        puts "\n\n"
                        puts shoe_details.shoe_name + "\n\n" + shoe_details.description + "\n\n\n\n"
                    else
                        puts "Invalid input, select a number accordingly."
                    end
                # when "N"
                #     menu
                # when "exit"
                #     finished
                #     break
                else
                    print "Input is invalid, type \'Y\' or \'N\': \n"
                end
            end
        end
    end

    def finished
        puts "Thank you for viewing the Air Max History! \nHave a Nice Day!"
    end

end