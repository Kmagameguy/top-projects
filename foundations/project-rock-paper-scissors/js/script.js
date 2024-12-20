console.log('get ready!');

const playerButtons = document.querySelectorAll('button');
const computerChoiceDisplay = document.querySelector('#computer-choice');
const playerChoiceDisplay = document.querySelector('#player-choice');
const roundResultDisplay = document.querySelector('#round-result');
const playerScoreDisplay = document.querySelector('#player-score');
const alienEasterEgg = document.querySelector('#alien-egg');
const secretWeaponButton = document.querySelector('#saucer');

const CHOICES = ["rock", "paper", "scissors"];
const THE_MEANING_OF_LIFE = 42;

const WIN_CONDITIONS = {
    "rock": "scissors",
    "paper": "rock",
    "scissors": "paper",
};

const VERBS = {
    "rock": "smashes",
    "paper": "covers",
    "scissors": "cuts",
    "saucer": "vaporizes"
};

let playerScore = 0;

function RoundResult(incrementScore, winningChoice=null, losingChoice=null) {
    let playerWinOrLose = incrementScore ? "You win!" : "You lose!";

    if (!winningChoice) {
        this.resultText = "It's a draw!";
    } else {
        this.resultText = `${playerWinOrLose} ${winningChoice} ${VERBS[winningChoice]} ${losingChoice}.`;
    }

    this.incrementScore = incrementScore;
}

function chanceOfAlienEncounter() {
    let roll = Math.floor(Math.random() * 1000);
    if (roll === THE_MEANING_OF_LIFE) {
        alienEasterEgg.classList.remove('hidden');
    }
}

function revealSecretWeapon() {
    secretWeaponButton.classList.remove('hidden');
    secretWeaponButton.removeAttribute('disabled');
    alienEasterEgg.remove();
}

function updateScore(playerScore) {
    playerScoreDisplay.textContent = `Score: ${playerScore}`;
}

function getComputerChoice() {
    return CHOICES[Math.floor(Math.random() * CHOICES.length )];
}

function playRound(playerChoice, computerChoice) {
    if (playerChoice === 'saucer') {
        return new RoundResult(true, playerChoice, computerChoice);
    } else if (playerChoice === computerChoice) {
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

function playGame(e) {
    chanceOfAlienEncounter();
    let playerChoice = e.target.id;
    let computerChoice = getComputerChoice();
    let roundResult = playRound(playerChoice, computerChoice);

    computerChoiceDisplay.textContent = `Computer chose: ${computerChoice}`;
    playerChoiceDisplay.textContent = `You chose: ${playerChoice}`;
    roundResultDisplay.textContent = `Result: ${roundResult.resultText}`;

    if(roundResult.incrementScore) {
        updateScore(++playerScore);
    }

    if (playerScore === 5) {
        roundResultDisplay.textContent += ' Congrats!  You won 5 rounds, game over!';
        playerButtons.forEach(button => button.disabled = true);
    }
}

updateScore(playerScore);
alienEasterEgg.addEventListener('click', revealSecretWeapon);
playerButtons.forEach(button => button.addEventListener('click',playGame));
