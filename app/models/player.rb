class Player < ActiveRecord::Base
  # Remember to create a migration!
  has_many :player_games
  has_many :games, through: :player_games

  validates :name, uniqueness: true
end
