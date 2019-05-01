document.addEventListener('turbolinks:load', function () {
    var timerControl = document.getElementById("timer")
    var formControl = document.getElementById("answer_form")

    if (timerControl) {
        var duration = timerControl.dataset.duration
        var t = duration_to_time(duration)
        timerControl.innerHTML = t.hours + ':' + t.minutes + ':' + t.seconds

        var timer = setTimeout(function tick() {
            t = duration_to_time(duration--)
            timerControl.innerHTML = t.hours + ':' + t.minutes + ':' + t.seconds

            if (duration == 0) { formControl.submit(); }

            timer = setTimeout(tick, 1000);
        }, 1000)
    }
});

function duration_to_time(duration) {
    var seconds = Math.floor((duration) % 60)
    var minutes = Math.floor((duration / 60) % 60)
    var hours = Math.floor((duration * 60 * 60) % 24)

    if (minutes < 10) { minutes = "0" + minutes }
    if (seconds < 10) { seconds = "0" + seconds }

    return {
        'total': duration,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
    };
}