const repeatString = function(string, repeatCount) {
    if (repeatCount < 0) { return 'ERROR'}

    let returnString = '';

    for (i = 0; i < repeatCount; i++) {
        returnString += string;
    }
    return returnString;
};

// Do not edit below this line
module.exports = repeatString;
