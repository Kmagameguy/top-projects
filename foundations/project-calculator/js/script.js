console.log('ready!');

const BUTTONS = document.querySelectorAll('button');
const CALCULATOR_DISPLAY = document.querySelector('#calculator-text');

let displayValue = 0;

function addNumbers(num1, num2) {
    return num1 + num2;
}

function subtractNumbers(num1, num2) {
    return num1 - num2;
}

function multiplyNumbers(num1, num2) {
    return num1 * num2;
}

function divideNumbers(num1, num2) {
    if (num2 === 0) { return 'Divide by Zero Error'}
    else { return num1 / num2 }
}

function appendToDisplay(number) {
    let currentDisplay = CALCULATOR_DISPLAY.innerText;
    CALCULATOR_DISPLAY.innerText = currentDisplay === '0' ? number : currentDisplay += number;
}

function operate(num1, num2, operator) {
    let result = '';
    switch(operator) {
        case '+':
            result = addNumbers(num1, num2);
            break;
        case '-':
            result = subtractNumbers(num1, num2);
            break;
        case '*':
            result = multiplyNumbers(num1, num2);
            break;
        case '/':
            result = divideNumbers(num1, num2);
            break;
    }
    return result;
}

function handleInput(e) {
    let selectedButton = e.target.innerText;

    if (!isNaN(parseInt(selectedButton))) {
        appendToDisplay(selectedButton);
    }

    console.log(operate(1, 3, '+'));
    console.log(operate(3, 1, '-'));
    console.log(operate(2, 3, '*'));
    console.log(operate(10, 5, '/'));
}

CALCULATOR_DISPLAY.innerText = displayValue;
BUTTONS.forEach(button => button.addEventListener('click',handleInput));
