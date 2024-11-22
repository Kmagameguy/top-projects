console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];

function getComputerChoice() {
  return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

console.log(`Computer chose: ${getComputerChoice()}`);
