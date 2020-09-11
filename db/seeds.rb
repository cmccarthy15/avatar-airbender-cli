require 'rest-client'
require 'pry'
require 'json'

Relationship.destroy_all
Affiliation.destroy_all
Nation.destroy_all
Character.destroy_all

nations = [
    {shorthand: "Fire", name: "Fire Nation"},
    {shorthand: "Air", name: "Air Nomads"}, 
    {shorthand: "Earth", name: "Earth Kingdom"}, 
    {shorthand: "North", name: "Northern Water Tribe"}, 
    {shorthand: "South", name: "Southern Water Tribe"}
]

puts "Seeding nations..."
nations.each do |n|
    Nation.create(n)
end
puts "Seeded #{Nation.all.count} nations"


def create_character_and_associations(character)
    target_name = character["name"].include?("(") ? character["name"].split[0] : character["name"]
    
    new_char = Character.find_by(name: target_name) ? Character.find_by(name: target_name) : Character.create({ 
            api_id: character["_id"], 
            name: target_name,
            photo_url: character["photoUrl"],
            is_avatar: false # should update to be dynamic
        })
    
    create_nation_affiliations(character, new_char)
    create_enemies(character, new_char)
    create_allies(character, new_char)
end

def create_nation_affiliations(character, new_char)
    affiliate_nations = Nation.all.filter{ |nat| character["affiliation"] ? character["affiliation"].include?(nat.shorthand) : false }
    affiliate_nations.each{ |nation| Affiliation.find_or_create_by(character: new_char, nation: nation)}
end

## do these in a second loop and smarter so there is no chance of duplicates
def create_enemies(character, new_char)
    character["enemies"].each do |enemy_name| 
        enemy_character = Character.find_by(name: enemy_name)
        if enemy_character
            if Relationship.find_by(character_one_id: new_char.id, character_two_id: enemy_character.id)
                Relationship.find_by(character_one_id: new_char.id, character_two_id: enemy_character.id).update(are_enemies: true, are_allies: false)
            else
                Relationship.create(character_one_id: new_char.id, character_two_id: enemy_character.id, are_enemies: true, are_allies: false)
            end
        end
    end
end

def create_allies(character, new_char)
    character["allies"].each do |ally_name| 
        ally_character = Character.find_by(name: ally_name)
        if ally_character
            if Relationship.find_by(character_one_id: new_char.id, character_two_id: ally_character.id)
                Relationship.find_by(character_one_id: new_char.id, character_two_id: ally_character.id).update(are_enemies: false, are_allies: true)
            else
                Relationship.create(character_one_id: new_char.id, character_two_id: ally_character.id, are_enemies: false, are_allies: true)
            end
        end
    end
end

characters =  RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?perPage=600'
parsed_characters = JSON.parse(characters)
# need to deal with multiple diff versions of characters

# aangs = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=aang')
# azula0 = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=azula')[0]
# azula1 = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=azula')[1]
# azula2 = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=azula')[2]
# appa = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=appa')[0]
# zukos = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=zuko')

parsed_characters.each do |character|
    create_character_and_associations(character)
end
binding.pry






# do the fetch
# for each character, create the character
# for each nation, filter by if the shorthand is included in the character affiliations
# make an affiliation for that user and each of filtered array
# also go through enemies, find related character and create relationship with right variable set to true
# also go through allies, ^^^