document.addEventListener('turbolinks:load', function () {
    var selectCriterion = document.querySelector("#badge_criterion");

    if (selectCriterion) {
        selectCriterion.addEventListener('change', formOptionsHandler);
    }

});

function formOptionsHandler() {
    var formParam = document.querySelector("#param");
    var selectParam = document.querySelector("#badge_param");
    var categoriesData = document.querySelector("#data-categories").dataset.categories;
    var testsData = document.querySelector("#data-tests").dataset.tests;
    var levelsData = document.querySelector("#data-levels").dataset.levels;
    var categories = JSON.parse(categoriesData);
    var tests = JSON.parse(testsData);
    var levels = JSON.parse(levelsData);

    formParam.classList.remove("hide");

    switch (this.value) {
        case 'first_try':
            setOptions(tests, selectParam);
            break;
        case 'all_category':
            setOptions(categories, selectParam);
            break;
        default:
            setOptionsForLevels(levels, selectParam)


    }
}

function setOptions(itemsArray, select) {
    select.options.length = 0;

    itemsArray.map(function (item) {

        var option = document.createElement("option");
        option.value = item[0];
        option.text = item[1];
        select.appendChild(option);
    })
}

function setOptionsForLevels(itemsArray, select) {
    select.options.length = 0;

    itemsArray.map(function (item) {
        console.log(item)
        var option = document.createElement("option");
        option.value = item
        option.text = item
        select.appendChild(option);
    })
}
