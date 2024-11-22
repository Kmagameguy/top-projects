console.log('ready!');

const BUTTONS = document.querySelectorAll('button');
const CALCULATOR_DISPLAY = document.querySelector('#calculator-text');

let firstNum = null;
let operator = null;
let secondNum = null;

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

function isNumber(value) {
    return !isNaN(parseInt(value));
}

function updateDisplay(number) {
    CALCULATOR_DISPLAY.innerText = number;
}

function updateOrAppendToDisplay(number) {
    let currentDisplay = CALCULATOR_DISPLAY.innerText;
    currentDisplay === '0' ? updateDisplay(number) : updateDisplay(currentDisplay + number);
}

function clearDisplay() {
    CALCULATOR_DISPLAY.innerText = '0';
    firstNum = null;
    operator = null;
    secondNum = null;
}

function shiftMemory() {
    firstNum = parseInt(CALCULATOR_DISPLAY.innerText);
    operator = null;
    secondNum = null;
}

function operate(num1, operator, num2) {
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

    if (selectedButton === 'AC') {
        clearDisplay();
    } else if (selectedButton === '=') {
        // We have to handle = separately since it can't be chained like other operators
        if (firstNum !== null && operator !== null && secondNum !== null) {
            secondNum = parseInt(CALCULATOR_DISPLAY.innerText);
            updateDisplay(operate(firstNum, operator, secondNum));
            firstNum = null;
            operator = null;
            secondNum = null;
        }
    } else if (firstNum === null && operator === null && secondNum === null) {
        if (isNumber(selectedButton)) {
            updateOrAppendToDisplay(selectedButton);
        } else {
            firstNum = parseInt(CALCULATOR_DISPLAY.innerText);
            operator = selectedButton;
        }
    // this condition is really only here to handle the display.  We want to show the previously
    // entered number until the user starts clicking buttons again.  After the first keypress we
    // wipe the display and show the newly entered number.  This condition sets the secondNum
    // to a value other than null so that it short circuits the next time around and
    // continues to the third else if statement in this chain
    } else if (firstNum !== null && operator !== null && secondNum === null) {
        if (isNumber(selectedButton)) {
            updateDisplay(selectedButton);
            secondNum = parseInt(selectedButton);
        }
    // this condition is what helps us chain operators together.  if the list of operations is full
    // we execute the stored stuff and then shift the values around so we're ready to take the next input
    } else if (firstNum !== null && operator !== null && secondNum !== null) {
        if (isNumber(selectedButton)) {
            updateOrAppendToDisplay(selectedButton);
        } else {
            secondNum = parseInt(CALCULATOR_DISPLAY.innerText);
            updateDisplay(operate(firstNum, operator, secondNum));
            shiftMemory();
            operator = selectedButton;
        }
    }
}

BUTTONS.forEach(button => button.addEventListener('click',handleInput));
