const convertToCelsius = function(ftemp) {
    let temp = (ftemp - 32) / 1.8;
    return roundToOneDecimal(temp);
};

const convertToFahrenheit = function(ctemp) {
    let temp = (ctemp * 1.8) + 32;
    return roundToOneDecimal(temp);
};

function roundToOneDecimal(num) {
    return Math.round(num * 10) / 10;
}

// Do not edit below this line
module.exports = {
  convertToCelsius,
  convertToFahrenheit
};
