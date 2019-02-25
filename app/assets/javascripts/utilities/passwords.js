var password;
var password_confirm;

document.addEventListener('turbolinks:load', function () {
    password = document.querySelector('.password_field');
    password_confirm = document.querySelector('.password_confirmation_field');

    if (password && password_confirm) {
        password.addEventListener('input',  password_comparison);
        password_confirm.addEventListener('input', password_comparison)};
});

function password_comparison() {
    if (password.value === password_confirm.value && (password.value != "")) {
        document.querySelector('.octicon-check').classList.remove('hide');
        document.querySelector('.octicon-alert').classList.add('hide');
    } else if (password_confirm.value === "") {
        document.querySelector('.octicon-check').classList.add('hide');
        document.querySelector('.octicon-alert').classList.add('hide');
    } else {
        document.querySelector('.octicon-check').classList.add('hide');
        document.querySelector('.octicon-alert').classList.remove('hide');
    }
}
