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
    new_char = Character.create({ 
        api_id: character["_id"], 
        name: character["name"],
        photo_url: character["photoUrl"],
        is_avatar: false # should update to be dynamic
    })
    affiliate_nations = Nation.all.filter{ |nat| character["affiliation"].include?(nat.shorthand)}
    affiliate_nations.each{ |nation| Affiliation.create(character: new_char, nation: nation)}

    character["enemies"].each do |enemy_name| 
        enemy_character = Character.find_by(name: enemy_name)
        if enemy_character
            Relationship.find_or_create_by(character_one_id: new_char.id, character_two_id: enemy_character.id, are_enemies: true, are_allies: false)
        end
    end
    character["allies"].each do |ally_name| 
        ally_character = Character.find_by(name: ally_name)
        if ally_character
            Relationship.find_or_create_by(character_one_id: new_char.id, character_two_id: ally_character.id, are_enemies: false, are_allies: true)
        end
    end
end

characters =  RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?perPage=10'
parsed_characters = JSON.parse(characters)
# need to deal with multiple diff versions of characters

aang = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=aang')[0]
azula = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=azula')[1]
appa = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=appa')[0]
zuko = JSON.parse(RestClient.get 'https://last-airbender-api.herokuapp.com/api/v1/characters?name=zuko')[2]

binding.pry
parsed_characters.each do |character|
    
end






# do the fetch
# for each character, create the character
# for each nation, filter by if the shorthand is included in the character affiliations
# make an affiliation for that user and each of filtered array
# also go through enemies, find related character and create relationship with right variable set to true
# also go through allies, ^^^