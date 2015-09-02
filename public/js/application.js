function GamePage () {

var Player = function(id){
	this.id = id;
	this.position = 1;

	function playerMove (player) {
		$("tr#player"+ this.playerNo +"_strip > td.active").removeClass().next().addClass('active')
		this.position ++
	}
	this.playerMove = playerMove;
};

var Game = function(player1,player2){
	this.player1 = player1;
	this.player2 = player2;
	this.player1.playerNo = "1";
	this.player2.playerNo = "2";

	function won () {
		if (player1.position == 14){
			alert("Player 1 has won!");
			var winner = player1.id;
			var loser = player2.id.;
			submitForm(winner,loser);
		}
		else if (player2.position == 14){
			alert("Player 2 has won!");
			var winner = player2.id;
			var loser = player1.id;
			submitForm(winner,loser);
		}
	}
	
	this.won = won;

	function submitForm(winner,loser) {
		forms = document.getElementById('result');
		forms.winner.value = winner;
		forms.loser.value = loser;
		forms.submit();
	}

	function restart_race () {
	player1_position = 1;
	player2_position = 1;

	$('tr#player1_strip > td').removeClass('active').first().addClass('active')
	$('tr#player2_strip > td').removeClass('active').first().addClass('active')
	}

	$("button#restart").click(function() {
	restart_race();
	});

};

var player1 = new Player(player1_id);
var player2 = new Player(player2_id);
var game = new Game(player1,player2);

$(document).keyup(function(keyCode){

	if (keyCode.which === 81){
		game.player1.playerMove();
	}
	else if(keyCode.which === 80){
		game.player2.playerMove();
	}

	game.won();
});

};

$(document).ready(function(){

	if($('body').hasClass('game_on')){
		GamePage();
	}
});
