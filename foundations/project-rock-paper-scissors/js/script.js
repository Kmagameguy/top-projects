console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];

function getComputerChoice() {
  return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
  playerChoice = playerChoice.toLowerCase();
  if (playerChoice === computerChoice) {
    return "It's a draw!";
  } else {
    return "Something else happened...";
  }
}

const playerChoice = 'rock';
const computerChoice = getComputerChoice();
console.log(`Computer chose: ${computerChoice}`);
console.log(playRound(playerChoice, computerChoice));
