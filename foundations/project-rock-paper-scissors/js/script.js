console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];
const NUM_ROUNDS = 5;

function getComputerChoice() {
  return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
  playerChoice = playerChoice.toLowerCase();
  if (playerChoice === computerChoice) {
    return "It's a draw!";
  } else if (playerChoice === 'rock' && computerChoice === 'paper') {
    return "You lose!  Paper covers rock.";
  } else if (playerChoice === 'rock' && computerChoice === 'scissors') {
    return "You win!  Rock smashes scissors.";
  } else if (playerChoice === 'paper' && computerChoice === 'rock') {
    return "You win!  Paper covers rock.";
  } else if (playerChoice === 'paper' && computerChoice === 'scissors') {
    return "You lose!  Scissors cut through paper.";
  } else if (playerChoice === 'scissors' && computerChoice === 'rock') {
    return "You lose!  Rock smashes scissors.";
  } else if (playerChoice === 'scissors' && computerChoice === 'paper') {
    return "You win!  Scissors cut through paper.";
  } else {
    return "We didn't understand your guess.  Try again.";
  }
}

function game() {
  for (let i = 0; i < NUM_ROUNDS; i++) {
    let playerChoice = prompt('Choose between rock, paper, or scissors:', 'rock');

    if (playerChoice !== null) {
      playerChoice = playerChoice.toLowerCase().trim();
      let computerChoice = getComputerChoice();

      console.log(`Computer chose: ${computerChoice}`);
      console.log(`You chose: ${playerChoice}`);
      console.log(`=> ${playRound(playerChoice, computerChoice)}`);
    } else {
      console.log("Game canceled!");
      break;
    }
  }
}

game();
