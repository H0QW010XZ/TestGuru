document.addEventListener('turbolinks:load', function () {
    var progressBar = document.querySelector('.progress-bar')
    if (progressBar) {
        var all = progressBar.dataset.allQuestions,
            current = progressBar.dataset.currentQuestion,
            progress_percentage = 100 / all * (current - 1)

        progressBar.style.width = progress_percentage + "%"
        progressBar.setAttribute('aria-valuenow', progress_percentage)

    }
});

