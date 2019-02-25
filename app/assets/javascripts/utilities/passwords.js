document.addEventListener('turbolinks:load', function () {
    var password = document.querySelector('#user_password')
    var password_confirmation = document.querySelector('#user_password_confirmation')

    if (password && password_confirmation) {
        password.addEventListener('input', password_comparison(password, password_confirmation))

        password_confirmation.addEventListener('input', password_comparison(password, password_confirmation))
    }
})

function password_comparison(password, password_confirmation) {
    if (password.value === password_confirmation.value && (password.value != "")) {
        document.querySelector('.octicon-check').classList.remove('hide');
        document.querySelector('.octicon-alert').classList.add('hide');
    } else if (password_confirmation.value === "") {
        document.querySelector('.octicon-check').classList.add('hide');
        document.querySelector('.octicon-alert').classList.add('hide');
    } else {
        document.querySelector('.octicon-check').classList.add('hide');
        document.querySelector('.octicon-alert').classList.remove('hide');
    }
}
