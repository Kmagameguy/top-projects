console.log('ready!');

const BUTTONS = document.querySelectorAll('button');
const DECIMAL_BUTTON = document.querySelector('#btn-decimal');
const CALCULATOR_DISPLAY = document.querySelector('#calculator-text');
const DIVIDE_BY_ZERO_MESSAGE = 'Divide by Zero Error';

class Memory {
    constructor() {
        this.firstNum  = null;
        this.operator  = null;
        this.secondNum = null;
    }

    equals() {
        if (this.firstNum !== null && this.operator !== null) {
            this.secondNum = display.getDisplayAsFloat();
            this.shift(this.#calculate());
        }
    }

    operate(operator) {
        if (this.firstNum === null) {
            this.firstNum = display.getDisplayAsFloat();
            this.operator = operator;
        } else if (this.operator === null) {
            this.operator = operator;
        } else {
            this.secondNum = display.getDisplayAsFloat();
            this.shift(this.#calculate(), operator);
        }
    }

    shift(answer=null, operator=null) {
        this.firstNum = answer;
        this.operator = operator;
        this.secondNum = null;
    }

    #add() {
        return this.firstNum + this.secondNum;
    }

    #subtract() {
        return this.firstNum - this.secondNum;
    }

    #multiply() {
        return this.firstNum * this.secondNum;
    }

    #divide() {
        if (this.secondNum === 0) {
            this.shift();
            return DIVIDE_BY_ZERO_MESSAGE
        } else {
            return this.firstNum / this.secondNum
        }
    }

    #calculate() {
        let result = '';
        switch(this.operator) {
            case '+':
                result = this.#add();
                break;
            case '-':
                result = this.#subtract();
                break;
            case '*':
                result = this.#multiply();
                break;
            case '/':
                result = this.#divide();
                break;
        }
        return result;
    }
};

let display = {
    frozen: false,
    update(text) {
        CALCULATOR_DISPLAY.innerText = text;
    },
    freeze() {
        this.frozen = true;
    },
    thaw() {
        this.frozen = false;
    },
    clear() {
        CALCULATOR_DISPLAY.innerText = '0';
        memory.shift();
    },
    getDisplayAsFloat() {
        return parseFloat(CALCULATOR_DISPLAY.innerText);
    },
    insertNumber(num) {
        if (this.isNotShowingError() && !this.frozen) {
            const currentDisplay = CALCULATOR_DISPLAY.innerText;
            currentDisplay === '0' ? this.update(num) : this.update(currentDisplay + num);
        } else {
            this.update(num);
            this.thaw();
        }
    },
    insertDecimal() {
        if(this.isNotShowingError() && !this.hasDecimal()) {
            const currentDisplay = CALCULATOR_DISPLAY.innerText;
            if (this.frozen || currentDisplay === 0) {
                this.thaw();
                this.update('0.');
            } else {
                this.update(currentDisplay + '.');
            }
        }
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

function handleInput(e) {
    let selectedButton = e.target.innerText;

    switch(selectedButton) {
        case 'AC':
            display.clear();
            break;
        case '+/-':
            display.invert();
            break;
        case '%':
            display.convertToDecimalPercentage();
            break;
        case '.':
            display.insertDecimal();
            break;
        case '=':
            memory.equals();
            display.update(memory.firstNum);
            break;
        case '/':
        case '*':
        case '-':
        case '+':
            display.freeze();
            memory.operate(selectedButton);
            display.update(memory.firstNum);
            break;
        default:
            display.insertNumber(selectedButton);
    }
}

let memory = new Memory();
BUTTONS.forEach(button => button.addEventListener('click', handleInput));
