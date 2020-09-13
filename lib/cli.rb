class CLI

    def run
        line_space(2)
        puts "Welcome to Fern's Forest, check out our plants!" 
        line_space(3)
        scrape_plants
        menu
    end

    def scrape_plants
        API.scrape_plants
    end

    def menu
        list_plants
        line_space(2)
        puts "Pick a number to learn more"
        input = gets.chomp

        if 0 < input.to_i && input.to_i <= Plants.all.count
            plant = Plants.all[input.to_i - 1]
            load_plant(plant)
            line_space(2)
            puts "You've selected #{plant.name}, nerds call me '#{plant.scientific_name}'.'"
            line_space(1)
            plant_names(plant)
            line_space(1)
            another_one
        else
            line_space(1)
            puts "That plant isn't in this grove, would you like to check out the next grove?"
            puts "Type 'next' to proceed to the next grove"
            puts "Type 'back' to return to the previous grove"
            puts "Hit enter to glance at this grove again"
            page_input = gets.chomp.downcase
            if page_input == "next"
                page_next
            elsif page_input == "back"
                page_back
            else
                menu
            end
        end 
    end

    def list_plants
        Plants.all.each.with_index(1) do |plant, i|
            puts "#{i}. #{plant.name}"
        end
    end

    def plant_names (plant)
        puts "In what language would you like to call me?"
        line_space(1)
        puts "Type 'spanish', 'french', or 'english' to see the common names in that language"
        lang_input = gets.chomp.downcase
        line_space(2)
        case lang_input
        when "spanish"
            plant.lang_es.each.with_index(1) { |name, i| puts "#{i}. #{name}"}
        when "french"
            plant.lang_fr.each.with_index(1) { |name, i| puts "#{i}. #{name}"}
        when "english"
            plant.lang_en.each.with_index(1) { |name, i| puts "#{i}. #{name}"}
        end    
    end

    def another_one
        puts "Would you like to see another plant? (y/n)"
        input = gets.chomp.downcase
        if input == "y"
            puts "... returning to the grove ..."
            line_space(1)
            menu
        elsif input == "n"
            goodbye 
        else
            goodbye           
        end
    end

    def load_plant (plant)
        API.scrape_plant_details(plant)
    end

    def page_next
        Plants.all.clear
        API.page_next
        API.scrape_plants
        menu
    end

    def page_back
        Plants.all.clear
        API.page_back
        API.scrape_plants
        menu
    end

    def line_space (lines)
        line = lines.to_i
        line.times { puts "" } 
    end

    def goodbye
        line_space(2)
        puts "... heading back to the concrete jungle ..."
        puts "
                        ,@@@@@@@,
                ,,,.   ,@@@@@@/@@,  .oo8888o.
             ,&%%&%&&%,@@@@@/@@@@@@,8888\88/8o
            ,%&\%&&%&&%,@@@\@@@/@@@88\88888/88'
            %&&%&%&/%&&%@@\@@/ /@@@88888\88888'
            %&&%/ %&%%&&@@\ V /@@' `88\8 `/88'
            `&%\ ` /%&'    |.|        \ '|8'
                |o|        | |         | |
                |.|        | |         | |
             \\/ ._\//_/__/  ,\_//__\\/.  \_//__/_
             "
        exit
    end

end