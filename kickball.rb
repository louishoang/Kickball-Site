require 'pry'
require 'sinatra'
require 'csv'


teams = []

CSV.foreach('views/lackp_starting_rosters.csv', headers: true, header_converters: :symbol) do |row|
  teams << row.to_hash
end

def find_by_team(teams, team_name)
  teams.find_all do |member|
    member[:team] == team_name
  end
end

def find_by_position(teams, pos)
  teams.find_all  do |member|
    member[:position] == pos
  end
end

get "/" do
  @teams = teams
  @team_name = []
  @team_position = []
  erb :index
end

get "/:team_name" do
  @players = find_by_team(teams, params[:team_name])
  erb :show
end

get "/position/:position" do
  @players_by_position = find_by_position(teams, params[:position])
  erb :show_position
end
