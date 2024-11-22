const leapYears = function(year) {
    if (divisibleBy4(year) && (!divisibleBy100(year) || divisibleBy400(year))) {
        return true
    } else {
        return false
    }
};

function divisibleBy4(year) {
    return (year % 4 === 0);
}

function divisibleBy100(year) {
    return (year % 100 === 0);
}

function divisibleBy400(year) {
    return (year % 400 === 0);
}

// Do not edit below this line
module.exports = leapYears;
