const GAME_BOARD = document.querySelector('#grid-container');
// 256 cells divides nicely into a 16x16 grid
const CELL_COUNT = 256;

function highlightBox(e) {
    e.target.classList.toggle('marked');
}

for (let i = 0; i < CELL_COUNT; i++) {
    const pixel = document.createElement('div');
        pixel.classList.add('grid-box');
        pixel.addEventListener('mouseover', highlightBox);
    GAME_BOARD.appendChild(pixel);
}
