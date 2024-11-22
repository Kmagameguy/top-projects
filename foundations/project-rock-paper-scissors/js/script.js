console.log('get ready!');

const CHOICES = ["rock", "paper", "scissors"];

const WIN_CONDITIONS = {
    "rock": "scissors",
    "paper": "rock",
    "scissors": "paper"
};

const VERBS = {
    "rock": "smashes",
    "paper": "covers",
    "scissors": "cuts"
};

function RoundResult(incrementScore, winningChoice=null, losingChoice=null) {
    let playerWinOrLose = incrementScore ? "You win!" : "You lose!";

    if (!winningChoice) {
        this.resultText = "It's a draw!";
    } else {
        this.resultText = `${playerWinOrLose} ${winningChoice} ${VERBS[winningChoice]} ${losingChoice}.`;
    }

    this.incrementScore = incrementScore;
}

function getComputerChoice() {
    return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
    if (playerChoice === computerChoice) {
        return new RoundResult(false);
    } else if (WIN_CONDITIONS[playerChoice] === computerChoice) {
        return new RoundResult(true, playerChoice, computerChoice);
    } else {
        return new RoundResult(false, computerChoice, playerChoice);
    }
}

function promptForPlayerHand() {
    let userInput = prompt('Choose between rock, paper, or scissors:', 'rock');
    return userInput !== null ? userInput.toLowerCase().trim() : userInput;
}

function playGame() {
    let playerScore = 0;

    let playerChoice = promptForPlayerHand();

    while (!CHOICES.includes(playerChoice) && playerChoice !== null) {
        console.log("We didn't understand your guess.  Try again.");
        playerChoice = promptForPlayerHand();
    }

    if (playerChoice !== null) {
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
    }
    console.log(`You won ${playerScore} rounds.`);
}

playGame();
