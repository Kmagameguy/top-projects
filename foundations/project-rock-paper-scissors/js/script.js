console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];
const NUM_ROUNDS = 5;

function getComputerChoice() {
  return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
  playerChoice = playerChoice.toLowerCase();
  if (playerChoice === computerChoice) {
    return { resultText: "It's a draw!", incrementScore: false };
  } else if (playerChoice === 'rock' && computerChoice === 'paper') {
    return { resultText: "You lose!  Paper covers rock.", incrementScore: false };
  } else if (playerChoice === 'rock' && computerChoice === 'scissors') {
    return { resultText: "You win!  Rock smashes scissors.", incrementScore: true };
  } else if (playerChoice === 'paper' && computerChoice === 'rock') {
    return { resultText: "You win!  Paper covers rock.", incrementScore: true };
  } else if (playerChoice === 'paper' && computerChoice === 'scissors') {
    return { resultText: "You lose!  Scissors cut through paper.", incrementScore: false };
  } else if (playerChoice === 'scissors' && computerChoice === 'rock') {
    return { resultText: "You lose!  Rock smashes scissors.", incrementScore: false };
  } else if (playerChoice === 'scissors' && computerChoice === 'paper') {
    return { resultText: "You win!  Scissors cut through paper.", incrementScore: true };
  } else {
    return { resultText: "We didn't understand your guess.  Try again.", incrementScore: false };
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
