class AirMax::Air
    attr_accessor :name, :name1, :name2, :max96, :zero, :shoe_name, :description

    @@all = []

    def initialize(shoe_name, description, max96, zero)
        @shoe_name = shoe_name
        @description = description
        @max96 = max96
        @zero = zero
        # am_hash.each {|key, value| self.send("#{key}", value)}
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