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
        this.firstNum = display.getDisplayAsFloat();
        this.operator = null;
        this.secondNum = null;
    },
    reset() {
        this.firstNum = null;
        this.operator = null;
        this.secondNum = null;
    },
    add() {
        return this.firstNum + this.secondNum;
    },
    subtract() {
        return this.firstNum - this.secondNum;
    },
    multiply() {
        return this.firstNum * this.secondNum;
    },
    divide() {
        if (this.secondNum === 0) {
            this.reset();
            return DIVIDE_BY_ZERO_MESSAGE
        } else {
            return this.firstNum / this.secondNum
        }
    },
    calculate() {
        let result = '';
        switch(this.operator) {
            case '+':
                result = this.add();
                break;
            case '-':
                result = this.subtract();
                break;
            case '*':
                result = this.multiply();
                break;
            case '/':
                result = this.divide();
                break;
        }
        return result;
    }
};

let display = {
    update(text) {
        CALCULATOR_DISPLAY.innerText = text;
    },
    clear() {
        CALCULATOR_DISPLAY.innerText = '0';
        memory.reset();
    },
    getDisplayAsFloat() {
        return parseFloat(CALCULATOR_DISPLAY.innerText);
    },
    hasDecimal() {
        return CALCULATOR_DISPLAY.innerText.indexOf('.') > -1
    },
    isNotShowingError() {
        return CALCULATOR_DISPLAY.innerText !== DIVIDE_BY_ZERO_MESSAGE;
    },
    invert() {
        if (this.isNotShowingError()) {
            this.update(-this.getDisplayAsFloat());
        }
    },
    convertToDecimalPercentage() {
        if (this.isNotShowingError()) {
            this.update(this.getDisplayAsFloat() / 100);
        }
    }
}

function isNumber(value) {
    return !isNaN(parseFloat(value));
}

function updateOrAppendToDisplay(text) {
    let currentDisplay = CALCULATOR_DISPLAY.innerText;
    if (!display.isNotShowingError()) {
        display.update(text);
    } else if (currentDisplay === '0' && text != '.') {
        display.update(text);
    } else {
        display.update(currentDisplay + text)
    }
}

function toggleDecimalButtonState() {
    DECIMAL_BUTTON.disabled = display.hasDecimal();
}

function handleInput(e) {
    let selectedButton = e.target.innerText;

    if (selectedButton === 'AC') {
        display.clear();
    } else if (selectedButton === '+/-') {
        display.invert();
    } else if (selectedButton === '%') {
        display.convertToDecimalPercentage();
    } else if (selectedButton === '=') {
        // We have to handle = separately since it can't be chained like other operators
        if (memory.firstNum !== null && memory.operator !== null && memory.secondNum !== null) {
            memory.secondNum = display.getDisplayAsFloat();
            display.update(memory.calculate());
            memory.reset();
        }
    } else if (memory.firstNum === null && memory.operator === null && memory.secondNum === null) {
        if (isNumber(selectedButton)) {
            updateOrAppendToDisplay(selectedButton);
        } else if (selectedButton === '.') {
            if (!display.hasDecimal()) {
                updateOrAppendToDisplay(selectedButton);
            }
        }
        else {
            memory.firstNum = display.getDisplayAsFloat();
            memory.operator = selectedButton;
        }
    // this condition is really only here to handle the display.  We want to show the previously
    // entered number until the user starts clicking buttons again.  After the first keypress we
    // wipe the display and show the newly entered number.  This condition sets the secondNum
    // to a value other than null so that it short circuits the next time around and
    // continues to the third else if statement in this chain
    } else if (memory.firstNum !== null && memory.operator !== null && memory.secondNum === null) {
        if (isNumber(selectedButton)) {
            display.update(selectedButton);
            memory.secondNum = parseFloat(selectedButton);
        }
    // this condition is what helps us chain operators together.  if the list of operations is full
    // we execute the stored stuff and then shift the values around so we're ready to take the next input
    } else if (memory.firstNum !== null && memory.operator !== null && memory.secondNum !== null) {
        if (isNumber(selectedButton) || selectedButton === '.') {
            updateOrAppendToDisplay(selectedButton);
        } else {
            memory.secondNum = display.getDisplayAsFloat();
            display.update(memory.calculate());
            memory.shift();
            memory.operator = selectedButton;
        }
    }

    toggleDecimalButtonState();
}

BUTTONS.forEach(button => button.addEventListener('click',handleInput));
