class Relationship < ActiveRecord::Base
    belongs_to :character_one, :class_name => :Character,:foreign_key => "character_one_id"
    belongs_to :character_two, :class_name => :Character,:foreign_key => "character_two_id"
end