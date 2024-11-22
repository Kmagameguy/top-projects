console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];
const NUM_ROUNDS = 5;

function RoundResult(resultText, incrementScore) {
  this.resultText = resultText;
  this.incrementScore = incrementScore;
}

function getComputerChoice() {
  return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
  playerChoice = playerChoice.toLowerCase();
  if (playerChoice === computerChoice) {
    return new RoundResult("It's a draw!", false);
  } else if (playerChoice === 'rock' && computerChoice === 'paper') {
    return new RoundResult("You lose! Paper covers rock.", false);
  } else if (playerChoice === 'rock' && computerChoice === 'scissors') {
    return new RoundResult("You win! Rock smashes scissors", true);
  } else if (playerChoice === 'paper' && computerChoice === 'rock') {
    return new RoundResult("You win! Paper covers rock.", true);
  } else if (playerChoice === 'paper' && computerChoice === 'scissors') {
    return new RoundResult("You lose! Scissors cut through paper.", false);
  } else if (playerChoice === 'scissors' && computerChoice === 'rock') {
    return new RoundResult("You lose! Rock smashes scissors.", false);
  } else if (playerChoice === 'scissors' && computerChoice === 'paper') {
    return new RoundResult("You win! Scissors cut through paper.", true);
  } else {
    return new RoundResult("We didn't understand your guess. Try again.", false);
  }
}

function game() {
  let playerScore = 0;

  for (let i = 0; i < NUM_ROUNDS; i++) {
    let playerChoice = prompt('Choose between rock, paper, or scissors:', 'rock');

    if (playerChoice !== null) {
      playerChoice = playerChoice.toLowerCase().trim();
      let computerChoice = getComputerChoice();
      let roundResult = playRound(playerChoice, computerChoice);

      console.log(`Computer chose: ${computerChoice}`);
      console.log(`You chose: ${playerChoice}`);
      console.log(`=> ${roundResult.resultText}`);

      if(roundResult.incrementScore) {
        ++playerScore;
      }
    } else {
      console.log("Game canceled!");
      break;
    }
  }
  console.log(`You won ${playerScore} rounds.`);
}

game();
