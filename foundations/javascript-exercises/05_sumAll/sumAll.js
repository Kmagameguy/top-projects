const sumAll = function(startingNum, endingNum) {

    if (startingNum < 0 || endingNum < 0) return 'ERROR'
    if (typeof startingNum !== 'number' || typeof endingNum !== 'number') return 'ERROR'

    nums = [startingNum, endingNum].sort();
    let sumTotal = 0;

    for (let i = nums[0]; i <= nums[1]; i++) {
        sumTotal += i;
    }

    return sumTotal;
};

// Do not edit below this line
module.exports = sumAll;
