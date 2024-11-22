const GAME_BOARD = document.querySelector('#grid-container');
const GRID_SIZE_BTN = document.querySelector('#change-grid');
// 256 cells divides nicely into a 16x16 grid
const CELL_COUNT = 256;
const CELL_THRESHOLDS = [1, 100];

function isBetween(num, min, max) {
    return (num >= min && num <= max);
}

function changeGridSize() {
    let userInput = parseInt(prompt('Set a new grid size:', 16));
    if (!userInput || !isBetween(userInput, ...CELL_THRESHOLDS)) {
        alert('Invalid option.  Input only accepts numbers between 1 and 100');
        return
    }
}

function highlightBox(e) {
    e.target.classList.toggle('marked');
}

for (let i = 0; i < CELL_COUNT; i++) {
    const pixel = document.createElement('div');
        pixel.classList.add('grid-box');
        pixel.addEventListener('mouseover', highlightBox);
    GAME_BOARD.appendChild(pixel);
}

GRID_SIZE_BTN.addEventListener('click', changeGridSize);
