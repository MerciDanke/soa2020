# frozen_string_literal: true

require 'http'
require 'yaml'
require 'json'

def poke_api_path(evolu_chain_id)
  "https://pokeapi.co/api/v2/evolution-chain/#{evolu_chain_id}"
end

# after call_poke_url we get the json object
def call_poke_url(url)
  JSON.parse(
    HTTP
      .get(URI(url))
  )
end

chain_results = {}

url = poke_api_path('1')
poke_obj = call_poke_url(url)

chain_results['chain_species'] = poke_obj['chain']['species']['name']
chain_results['evolves_to'] = poke_obj['chain']['evolves_to'][0]['species']['name']
ev2 = poke_obj['chain']['evolves_to'][0]['evolves_to']
# chain_results['evolves_to_2'] = ev2[0].nil? ? nil : ev2[0]['species']['name']
chain_results['evolves_to_second'] = ev2[0]['species']['name'] if ev2[0]
# put the evolution chain's species into the yaml file
File.write('spec/fixtures/poke_data/evolution_chain_results.yml', chain_results.to_yaml)
