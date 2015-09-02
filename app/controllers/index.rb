enable :sessions

get '/' do
  # Look in app/views/index.erb
  @player = Player.all 
  erb :index
end


get '/player/create' do
  erb :createplayer
end

post '/player/create' do
  input = params[:name]

  @playername = Player.find_by(name: input)

  if @playername
    @playername
    redirect '/player/create'
  else
    Player.create(name: input)
    redirect '/'
  end
end

post '/game' do 
 if params[:player1] == params[:player2]
  redirect '/'
 else
    @player1 = params[:player1]
    @player2 = params[:player2]
    current_game = Game.create()

    redirect "/game/#{@player1}/#{@player2}/#{current_game.id}"
  end
end

get '/game/:player1/:player2/:game_id' do 
  @player1 = Player.find(params[:player1])
  @player2 = Player.find(params[:player2])
  @game = Game.find(params[:game_id])
  @player1.games << @game
  @player2.games << @game

  @page_name = "game_on"
  session[:player1] = @player1.id
  session[:player2] = @player2.id
  session[:time] = Time.now

  erb :'gamebegin'  
end

post '/result' do
  @time_taken = Time.now - session[:time]
  @input = Game.find(params[:game])
  @input.update(
    winner_id: params[:winner],
    loser_id: params[:loser],
    time_taken: @time_taken
    )

  redirect "/result/#{@input.id}"
end

get '/result/:id' do 
  @game = Game.find(params[:id])
  @player_win = Player.find(@game.winner_id)
  @player_lose = Player.find(@game.loser_id)
  erb :gameresult
end

get '/viewgame' do
  @game = Game.all
  @playergame = PlayerGame.all
  @player = Player.all 
  erb :viewresult
end