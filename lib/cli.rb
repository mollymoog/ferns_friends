class CLI



    def run
        puts "Welcome to Fern's Friends, lets meet some other plants"
        scrape_plants
        menu
    end

    def scrape_plants
        API.scrape_plants
    end

    def menu
        list_plants
        puts "pick a number to learn more"
        input = gets.chomp

        if 0 < input.to_i && input.to_i <= Plants.all.count
            plant = Plants.all[input.to_i - 1]
            load_plant(plant)

            puts "You've selected #{plant.name}, scientifically referred to as '#{plant.scientific_name}'.'"
            line_space(1)
            puts "What else would you like to know?"
            puts "to le"
            line_space(1)
            plant_names(plant)
            line_space(1)
            puts "would you like to see another plant? (y/n)"
            input = gets.chomp
            if input == "y"
                puts "returning to menu ..."
                line_space(1)
                menu
            elsif input == "n"
                puts "see you next time"
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
             \\/ ._\//_/__/  ,\_//__\\/.  \_//__/_"
                exit
            else
                puts ""
            
            end
        else
            puts "That number isn't on this page."
            puts "If you'd like to see the next page, type 'next'"
            puts "Otherwise, press any enter to be redirected to the main menu"
            page_input = gets.chomp
                if page_input == "next"
                    puts "turning page" #method to turn page
                    page_next
                    menu
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
        puts "what language would you like to translate to :"
        line_space(1)
        puts "type 'spanish', 'french', or 'english' to see the common names in that language"
        line_space(2)
        lang_input = gets.chomp.downcase

        case lang_input
        when "spanish"
            plant.lang_es.each.with_index(1) { |name, i| puts "#{i}. #{name}"}
        when "french"
            plant.lang_fr.each.with_index(1) { |name, i| puts "#{i}. #{name}"}
        when "english"
            plant.lang_en.each.with_index(1) { |name, i| puts "#{i}. #{name}"}
        end    
    end

    def load_plant (plant)
        API.scrape_plant_details(plant)
    end

    def page_next
        Plants.all.clear
        API.page_next
        API.scrape_plants
    end

    def page_back
        Plants.all.clear
        API.page_back
        API.scrape_plants
    end

    def line_space (lines)
        line = lines.to_i
        line.times { puts ""}
    end

end