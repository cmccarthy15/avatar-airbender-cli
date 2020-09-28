class Character < ActiveRecord::Base
    has_many :affiliations
    has_many :nations, through: :affiliations
    has_many :relationships

    def is_katara
        return self.name.include?("Katara")
    end
end

