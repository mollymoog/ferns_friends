class CLI

    def run
        puts "Welcome to Fern's Friends, lets find some friends"
     
        API.scrape_plants
        list_plants
        menu
    end

    def list_plants
        Plants.all.each.with_index(1) do |plant, i|
            puts "#{i}. #{plant.name}"
        end
    end

    def menu
        puts "pick a number to get to learn more"
        input = gets.chomp

        if 0 < input.to_i && input.to_i <= 20
            plant = Plants.all[input.to_i - 1]

            puts "You've selected #{plant.name}"
        else
            puts "That number isn't on this page."
            puts "If you'd like to see the next page, type 'next'"
            puts "Otherwise, press any enter to be redirected to the main menu"
            page_input = gets.chomp
                if page_input == "next"
                    puts "turning page" #method to turn page
                else
                    menu
                end
                       
        end 
    end



    def plant_names
        puts "what language would you like to use"
        puts "type "


    end

end