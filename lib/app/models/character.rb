class Character < ActiveRecord::Base
    has_many :affiliations
    has_many :nations, through: :affiliations
    has_many :relationships

    def self.water_tribe_members
        self.all.filter { |char| character.nation == "Water Tribe" }
    end

    def self.fire_nation_members
        self.all.filter { |char| character.nation == "Fire Nation" }
    end

    ## Pretend we have air nomads and earth kingdom 
end

