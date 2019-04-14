class AirMax::Air
    attr_accessor :name, :shoe_name, :description

    @@all = []

    def initialize(shoe_name, description)
        @shoe_name = shoe_name
        @description = description
        @@all << self
    end

    def self.save
        @@all << self
        self
    end

    def self.all
        @@all
    end
end