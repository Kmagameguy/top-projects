const GAME_BOARD = document.querySelector('#grid-container');
const GRID_SIZE_BTN = document.querySelector('#change-grid');
const GRID_MAX_SIZE = 512;
const CELL_THRESHOLDS = [1, 100];
const RGB_MAX_VALUE = 255;

const Grid = class {
    constructor(size) {
        this.width = size || 16;
        this.height = this.width;
        this.totalCells = this.width ** 2;
        this.cellSize = `${GRID_MAX_SIZE/this.width}px`;
    }

    isValidGridSize(num,min,max) {
        return (num >= min && num <= max);
    }

    drawGrid() {
        for (let i = 0; i < this.totalCells; i++) {
            this.addCell();
        }
    }

    addCell() {
        const cell = document.createElement('div');
        cell.classList.add('grid-box');
        cell.addEventListener('mouseover', highlightBox);
        cell.style.width = cell.style.height = this.cellSize;
        GAME_BOARD.appendChild(cell);
    }

    resetGrid() {
        while (GAME_BOARD.firstChild) {
            GAME_BOARD.removeChild(GAME_BOARD.firstChild);
        }
    }
}

function changeGridSize() {
    let userInput = parseInt(prompt('Set a new grid size:', 16));
    if (!userInput || !grid.isValidGridSize(userInput, ...CELL_THRESHOLDS)) {
        alert('Invalid option. Input only accepts numbers between 1 and 100');
        return
    }

    grid.resetGrid();
    grid = new Grid(userInput);
    grid.drawGrid();
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

let grid = new Grid(16);
grid.drawGrid();

GRID_SIZE_BTN.addEventListener('click', changeGridSize);
