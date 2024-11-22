const add = function(a, b) {
    return a + b;
};

const subtract = function(a, b) {
	return a - b;
};

const sum = function(a) {
    return a.reduce((total,current) => total + current, 0);
};

const multiply = function(a) {
    return a.flat().reduce((total, value) => {
        return total * value;
    },1)
};

const power = function(a, b) {
    return a ** b;
};

const factorial = function(a) {
    let factors = [];
    for (let i = a; i > 0; i--) {
        factors.push(i);
    }

    return factors.reduce((total, current) => total * current, 1);

};

// Do not edit below this line
module.exports = {
  add,
  subtract,
  sum,
  multiply,
  power,
  factorial
};
