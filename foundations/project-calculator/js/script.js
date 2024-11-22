console.log('ready!');

const BUTTONS = document.querySelectorAll('button');
const DECIMAL_BUTTON = document.querySelector('#btn-decimal');
const CALCULATOR_DISPLAY = document.querySelector('#calculator-text');
const DIVIDE_BY_ZERO_MESSAGE = 'Divide by Zero Error';

let memory = {
    firstNum: null,
    operator: null,
    secondNum: null,
    shift() {
        this.firstNum = parseFloat(CALCULATOR_DISPLAY.innerText);
        this.operator = null;
        this.secondNum = null;
    },
    reset() {
        this.firstNum = null;
        this.operator = null;
        this.secondNum = null;
    }
};

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
    if (num2 === 0) {
        memory.reset();
        return DIVIDE_BY_ZERO_MESSAGE
    } else { return num1 / num2 }
}

function isNumber(value) {
    return !isNaN(parseFloat(value));
}

function updateDisplay(text) {
    CALCULATOR_DISPLAY.innerText = text;
}

function updateOrAppendToDisplay(text) {
    let currentDisplay = CALCULATOR_DISPLAY.innerText;
    if (currentDisplay === DIVIDE_BY_ZERO_MESSAGE) {
        updateDisplay(text);
    } else if (currentDisplay == '0' && text != '.') {
        updateDisplay(text);
    } else {
        updateDisplay(currentDisplay + text)
    }
}

function clearDisplay() {
    CALCULATOR_DISPLAY.innerText = '0';
    memory.reset();
}

function invertDisplay() {
    let currentDisplay = CALCULATOR_DISPLAY.innerText;
    if (currentDisplay !== DIVIDE_BY_ZERO_MESSAGE) {
        CALCULATOR_DISPLAY.innerText = -parseFloat(currentDisplay);
    }
}

function convertDisplayToDecimalPercentage() {
    let currentDisplay = CALCULATOR_DISPLAY.innerText;
    if (currentDisplay !== DIVIDE_BY_ZERO_MESSAGE) {
        CALCULATOR_DISPLAY.innerText = parseFloat(currentDisplay) / 100;
    }
}

function displayHasDecimal() {
    return CALCULATOR_DISPLAY.innerText.indexOf('.') > -1;
}

function toggleDecimalButtonState() {
    DECIMAL_BUTTON.disabled = displayHasDecimal();
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
    } else if (selectedButton === '+/-') {
        invertDisplay();
    } else if (selectedButton === '%') {
        convertDisplayToDecimalPercentage();
    } else if (selectedButton === '=') {
        // We have to handle = separately since it can't be chained like other operators
        if (memory.firstNum !== null && memory.operator !== null && memory.secondNum !== null) {
            memory.secondNum = parseFloat(CALCULATOR_DISPLAY.innerText);
            updateDisplay(operate(memory.firstNum, memory.operator, memory.secondNum));
            memory.reset();
        }
    } else if (memory.firstNum === null && memory.operator === null && memory.secondNum === null) {
        if (isNumber(selectedButton)) {
            updateOrAppendToDisplay(selectedButton);
        } else if (selectedButton === '.') {
            if (CALCULATOR_DISPLAY.innerText.indexOf('.') === -1) {
                updateOrAppendToDisplay(selectedButton);
            }
        }
        else {
            memory.firstNum = parseFloat(CALCULATOR_DISPLAY.innerText);
            memory.operator = selectedButton;
        }
    // this condition is really only here to handle the display.  We want to show the previously
    // entered number until the user starts clicking buttons again.  After the first keypress we
    // wipe the display and show the newly entered number.  This condition sets the secondNum
    // to a value other than null so that it short circuits the next time around and
    // continues to the third else if statement in this chain
    } else if (memory.firstNum !== null && memory.operator !== null && memory.secondNum === null) {
        if (isNumber(selectedButton)) {
            updateDisplay(selectedButton);
            memory.secondNum = parseFloat(selectedButton);
        }
    // this condition is what helps us chain operators together.  if the list of operations is full
    // we execute the stored stuff and then shift the values around so we're ready to take the next input
    } else if (memory.firstNum !== null && memory.operator !== null && memory.secondNum !== null) {
        if (isNumber(selectedButton) || selectedButton === '.') {
            updateOrAppendToDisplay(selectedButton);
        } else {
            memory.secondNum = parseFloat(CALCULATOR_DISPLAY.innerText);
            updateDisplay(operate(memory.firstNum, memory.operator, memory.secondNum));
            memory.shift();
            memory.operator = selectedButton;
        }
    }

    toggleDecimalButtonState();
}

BUTTONS.forEach(button => button.addEventListener('click',handleInput));
