const palindromes = function (a) {

    forwards = a.toLowerCase()
            .replace(/[^a-zA-Z]/g, '')
            .split('')
            .join('');

    reverse = a.toLowerCase()
            .replace(/[^a-zA-Z]/g,'')
            .split('')
            .reverse()
            .join('');

    return forwards === reverse;
};

// Do not edit below this line
module.exports = palindromes;
