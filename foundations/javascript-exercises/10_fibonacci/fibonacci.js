const fibonacci = function(index) {
    if (index < 0) return 'OOPS';
    let start = 0;
    let end   = 1;

    for (let i = 1; i < index; i++) {
        const prevValue = end;
        end = start + prevValue;
        start = prevValue;
    }

    return end;
};

// Do not edit below this line
module.exports = fibonacci;
