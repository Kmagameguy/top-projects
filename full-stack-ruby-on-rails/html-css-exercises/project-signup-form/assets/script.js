const passwordField = document.querySelector('input[name=password]');
const confirmField = document.querySelector('input[name=password-confirmation');

function validatePassword() {
    if (passwordBlank()) {
        setValidationMessage('Password cannot be blank!');
    } else if (passwordDoesNotMeetRequirements()) {
        setValidationMessage('Password must be 8 or more characters, and contain at least 1 number, 1 uppercase letter, and 1 lowercase letter.');
    } else if (passwordsDoNotMatch()) {
        setValidationMessage('Passwords must match!');
    } else {
        setValidationMessage('');
    }
}

function passwordBlank() {
    return passwordField.value == '' || passwordField.value == null || passwordField.value == undefined;
}

function passwordDoesNotMeetRequirements() {
    const passwordRequirementsRegex = new RegExp('(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}');
    return !passwordRequirementsRegex.test(passwordField.value);
}

function passwordsDoNotMatch() {
    return passwordField.value != confirmField.value;
}

function setValidationMessage(message) {
    passwordField.setCustomValidity(message);
    setErrorFlag(message);
}

function setErrorFlag(message) {
    if (message.length) {
        passwordField.classList.add('error');
        confirmField.classList.add('error');
    } else {
        passwordField.classList.remove('error');
        confirmField.classList.remove('error');
    }
}

passwordField.onchange = validatePassword;
confirmField.onkeyup = validatePassword;

