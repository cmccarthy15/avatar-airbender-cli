class Nation < ActiveRecord::Base
    has_many :affiliations
    has_many :characters, through: :affiliations
end