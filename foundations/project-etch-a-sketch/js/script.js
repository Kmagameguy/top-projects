const GAME_BOARD = document.querySelector('#grid-container');
const GRID_SIZE_BTN = document.querySelector('#change-grid');
const GRID_MAX_SIZE = 512;
const CELL_THRESHOLDS = [1, 100];
const RGB_MAX_VALUE = 255;


function drawGrid(numCellsPerSide=16) {
    resetGameBoard();
    let totalCells = calculateNumberOfCells(numCellsPerSide);
    for (let i = 0; i < totalCells; i++) {
        const cell = document.createElement('div');
            cell.classList.add('grid-box');
            cell.addEventListener('mouseover', highlightBox);
            cell.style.width = cell.style.height = setCellSize(numCellsPerSide);
        GAME_BOARD.appendChild(cell);
    }
}

function changeGridSize() {
    let userInput = parseInt(prompt('Set a new grid size:', 16));
    if (!userInput || !isBetween(userInput, ...CELL_THRESHOLDS)) {
        alert('Invalid option.  Input only accepts numbers between 1 and 100');
        return
    }

    drawGrid(userInput);
}

function resetGameBoard() {
    while (GAME_BOARD.firstChild) {
        GAME_BOARD.removeChild(GAME_BOARD.firstChild);
    }
}

function isBetween(num, min, max) {
    return (num >= min && num <= max);
}

function setCellSize(numBoxes) {
    return `${GRID_MAX_SIZE/numBoxes}px`;
}

function calculateNumberOfCells(width) {
    return width ** 2;
}

function highlightBox(e) {
    if (e.target.style.backgroundColor) { e.target.style.backgroundColor = '' }
    else {
        e.target.style.backgroundColor = `rgb(${randValueOnRGBScale()}, ${randValueOnRGBScale()}, ${randValueOnRGBScale()})`;
    }
}

function randValueOnRGBScale() {
    return Math.floor(Math.random() * RGB_MAX_VALUE);
}

drawGrid();
GRID_SIZE_BTN.addEventListener('click', changeGridSize);
