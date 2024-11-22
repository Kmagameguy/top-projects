const BUTTONS = document.querySelectorAll('button');
const DIVIDE_BY_ZERO_MESSAGE = 'Divide by Zero Error';

class Memory {
    constructor() {
        this.firstNum  = null;
        this.operator  = null;
        this.secondNum = null;
    }

    equals() {
        if (this.firstNum !== null && this.operator !== null) {
            this.secondNum = display.getFloat();
            this.shift(this.#calculate());
            display.update(this.firstNum)
        }
    }

    operate(operator) {
        if (this.firstNum === null) {
            this.firstNum = display.getFloat();
            this.operator = operator;
        } else if (this.operator === null) {
            this.operator = operator;
        } else {
            this.secondNum = display.getFloat();
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

class Display {
    constructor() {
        this.frozen = false;
        this.calculatorDisplay = document.querySelector('#calculator-text');
    }

    update(text) {
        this.calculatorDisplay.innerText = text;
    }

    freeze() {
        this.frozen = true;
    }

    clear() {
        this.update('0');
        memory.shift();
    }

    getFloat() {
        return parseFloat(this.#getText());
    }

    invert() {
        if (this.#isNotShowingError()) {
            this.update(-this.getFloat());
        }
    }

    convertToDecimalPercentage() {
        if (this.#isNotShowingError()) {
            this.update(this.getFloat() / 100);
        }
    }

    insertDecimal() {
        if (this.frozen || this.#getText() === '0') {
            this.#thaw();
            this.update('0.');
        } else if(this.#isNotShowingError() && !this.#hasDecimal()) {
            this.update(this.#getText() + '.');
        }
    }

    insertNumber(num) {
        if (this.#isNotShowingError() && !this.frozen) {
            const currentDisplay = this.#getText();
            currentDisplay === '0' ? this.update(num) : this.update(currentDisplay + num);
        } else {
            this.#thaw();
            this.update(num);
        }
    }

    #getText() {
        return this.calculatorDisplay.innerText;
    }

    #thaw() {
        this.frozen = false;
    }

    #hasDecimal() {
        return this.#getText().indexOf('.') > -1
    }

    #isNotShowingError() {
        return this.#getText() !== DIVIDE_BY_ZERO_MESSAGE;
    }
}

function handleInput(e) {
    let selectedButton = e.target.innerText;

    if (isNaN(display.getFloat())) {
        display.clear();
    }

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
let display = new Display();

BUTTONS.forEach(button => button.addEventListener('click', handleInput));
