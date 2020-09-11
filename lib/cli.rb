class CLI



    def run
        puts "Welcome to Fern's Friends, lets meet some other plants"
        API.scrape_plants
        menu
    end

    def menu
        list_plants
        puts "pick a number to learn more"
        input = gets.chomp

        if 0 < input.to_i && input.to_i <= 20
            plant = Plants.all[input.to_i - 1]
            load_plant(plant)

            puts "You've selected #{plant.name}, more scientifically referred to as '#{plant.scientific_name}'.'"
            puts "What else would you like to know?"
            puts ""
            plant_names(plant)
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

    def list_plants
        Plants.all.each.with_index(1) do |plant, i|
            puts "#{i}. #{plant.name}"
        end
    end

    def plant_names (plant)
        puts "what language would you like to translate to :"
        puts "type 'spanish', 'french', or 'english' to see the common names in that language"
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

end