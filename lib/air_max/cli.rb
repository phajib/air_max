class AirMax::CLI
    def start
        title = "A HISTORY IN AIR MAX".bold.yellow
        puts center_align(title)
        AirMax::Scraper.new.scrape_page # scrape page
        am_intro   # show brief history of Air Max shoes, scraped from site
        menu       # display menu
    end

    #  am_intro: Scrapes the introduction text from the website and is used
    #  as the welcome message for the CLI.
    def am_intro
        doc = Nokogiri::HTML(open("https://www.sneakerfreaker.com/articles/history-inspiration-air-max/"))
        puts center_align(string_wrap(doc.css("section.content p").text).yellow)
    end

    # menu: A listing of Air Max shoes is displayed. The user has three options
    # to choose from. Select a shoe by typing a number between 1-27; to view a
    # a list of Air Max shoes; and typing exit to quit. If a invalid input is
    # typed in, an error message is displayed and the user will be asked to
    # type list or exit.
    def menu
        shoe_list       # Display a list of Air Max shoes
        input = nil
        while input != "exit"
            puts "\nTo view a list of Air Max shoes type".yellow + " \'list\'".bold.yellow + ".".yellow
            puts "To view the history of a particular shoe, choose a number between".yellow + " 1 - 27".bold.yellow + ".".yellow
            print "To quit, type ".yellow + "\'exit\'".bold.yellow + ": ".yellow
            input = gets.strip.downcase
            # receive users input and check it's validity
            if input.to_i.between?(1,27)
                am_list(input)
            elsif input == "list"
                shoe_list
            elsif input == "exit"
                finished
            else
                puts "Invalid input".blink.red + ", type list or exit.".red
                menu
            end
        end
    end

    # shoe_list: creates a list of all the Air Max shoes from the scraped
    # website by retrieving the all array from the Air class, where the
    # various shoe names are stored.
    def shoe_list
        lines = ('=' * 38).yellow
        puts center_align("\nNike Air Max from 1978 - 2019".bold.yellow)
        puts center_align(lines)

        @am_shoes = AirMax::Air.all
        @am_shoes.each.with_index(1) do |shoe, i|
            if i == 13 || i == 24
                zero96 = "    #{i}. #{shoe.shoe_name}".yellow
                puts center_align(zero96)
            else
                am_name = "   #{i}. #{shoe.shoe_name}".yellow
                puts center_align(am_name)
            end
        end
        puts center_align(lines)
    end

    # am_list: when the user inputs a number it retrieves the name of a shoe
    # and it's information regarding the history of the corresponding number.
    # The data is pulled from the instance variable.
    def am_list(input)
        shoe_num = input.to_i - 1
        shoe_details = @am_shoes[shoe_num]

        if shoe_num == 13 || shoe_num == 24
            puts center_align("\n\n#{shoe_details.shoe_name}".bold.yellow)
            puts center_align(string_wrap("\n#{shoe_details.description}\n\n".yellow))

        else
            puts center_align("\n\n#{shoe_details.shoe_name}".bold.yellow)
            puts center_align(string_wrap("\n#{shoe_details.description}\n\n".yellow))
        end
    end

    # finished: appreciation message is displayed before exiting.
    def finished
        puts center_align("\n\nThank you for viewing the Air Max History!\nHave a Nice Day!".bold.yellow)
        exit
    end

    # center_align: Takes the arguement 'text' and takes line by line upto 100,
    # center aligns it, .center and join the rest via a new line, "\n"
    def center_align(text)
        text.lines.map {|line| line.strip.center(100)}.join("\n")
    end


    # string_wrap: Takes the arguement 'text' and checks the length. If its
    # less than 75, keep it as is. If it's greater than 75 then split after 75
    # to a newline.
    def string_wrap(text)
        if text.length < 75
            text
        else
            text.strip.split("\n").join("").gsub(/(.{1,75})( +|$\n?)|(.{1,75})/,"\\1\\3\n")
        end
    end

end