class Plants
    @@all = []

    attr_accessor :name, :url, :flower, :edible, :vegetable, :fruit, :scientific_name, :lang_es, :lang_fr, :lang_en

    def initialize(plant)
        self.name = plant[:common_name]
        self.url = plant[:links][:plant]
        @@all << self
    end

    def self.all
        @@all
    end 

end