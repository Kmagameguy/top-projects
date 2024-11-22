console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];
const NUM_ROUNDS = 5;

const WIN_CONDITIONS = {
    "rock": "scissors",
    "paper": "rock",
    "scissors": "paper"
}

function RoundResult(resultText, incrementScore) {
    this.resultText = resultText;
    this.incrementScore = incrementScore;
}

function getComputerChoice() {
    return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
    if (playerChoice === computerChoice) {
        return new RoundResult("It's a draw!", false);
    } else if (WIN_CONDITIONS[playerChoice] === computerChoice) {
        return new RoundResult("You win!", true);
    } else {
        return new RoundResult("You lose!", false);
    }
}

function playGame() {
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

playGame();
