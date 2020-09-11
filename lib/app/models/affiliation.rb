class Affiliation < ActiveRecord::Base
    belongs_to :character
    belongs_to :nation
end