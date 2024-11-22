const findTheOldest = function(people) {
    currentDate = (new Date()).getFullYear();
    return people.reduce((oldest, nextPerson) => {
        oldest.age = !oldest.yearOfDeath ? currentDate - oldest.yearOfBirth : oldest.yearOfDeath - oldest.yearOfBirth;
        nextPerson.age = !nextPerson.yearOfDeath ? currentDate - nextPerson.yearOfBirth : nextPerson.yearOfDeath - nextPerson.yearOfBirth;
        return oldest.age > nextPerson.age ? oldest : nextPerson;
    });
};

// Do not edit below this line
module.exports = findTheOldest;
