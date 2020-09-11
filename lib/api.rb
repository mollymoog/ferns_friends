
require 'rest-client'
require 'json'
require 'pry'
require_relative 'plants'

class API
  attr_accessor :plants_names

  def self.scrape_plants
    resp = RestClient.get('https://trefle.io/api/v1/plants?token=28lRdBdWEwCfHbsosT8M3JBKY6gaVRvzEzUyBvBEz7Q')
    plants_hash = JSON.parse(resp.body, symbolize_names:true)
    plants_arr = plants_hash[:data]

    plants_arr.collect do | plant |
      Plants.new(plant)
    end
  end

  def self.scrape_plant_details (plant)
    # @plants_names.each do | plant |
      resp = RestClient.get('https://trefle.io' + plant.url + '?token=28lRdBdWEwCfHbsosT8M3JBKY6gaVRvzEzUyBvBEz7Q')
      plant_hash = JSON.parse(resp.body, symbolize_names:true)

      plant.flower = plant_hash[:data][:main_species][:flower][:conspicuous]      
      plant.edible = plant_hash[:data][:main_species][:edible]
      plant.vegetable = plant_hash[:data][:main_species][:vegetable]
      plant.fruit = plant_hash[:data][:main_species][:fruit_or_seed][:conspicuous]

      plant.scientific_name = plant_hash[:data][:main_species][:scientific_name]
      plant.lang_es = plant_hash[:data][:main_species][:common_names][:es]
      plant.lang_fr = plant_hash[:data][:main_species][:common_names][:fr]
      plant.lang_en = plant_hash[:data][:main_species][:common_names][:en]
    # end
  end

end
