document.addEventListener('turbolinks:load', function () {
    var control = document.querySelector('.sort-by-title')

    // без доп функции не работает

    if (control) {

        control.addEventListener('click', function () {
            sortRowsByTitle(this)
        })
    }
});


function sortRowsByTitle(t) {
    var table = document.querySelector('table')
    var thead = document.querySelector('thead')

    // NodeLists
    var tbodyGetRows = table.querySelector('tbody')
    var tbodyRows = tbodyGetRows.querySelectorAll('tr')
    var sortedRows = []

    addTbodyRows(sortedRows, tbodyRows)

    if (t.querySelector('.octicon-arrow-up').classList.contains('hide')) {
        sortedRows.sort(compareRowsAsc)
        t.querySelector('.octicon-arrow-up').classList.remove('hide')
        t.querySelector('.octicon-arrow-down').classList.add('hide')
    } else {
        sortedRows.sort(compareRowsDesc)
        t.querySelector('.octicon-arrow-down').classList.remove('hide')
        t.querySelector('.octicon-arrow-up').classList.add('hide')
    }


    var sortedTable = document.createElement('table')

    var tbody = sortedTable.createTBody()

    var table_cl = ["table", "table-dark", "table-bordered", "table-hover"]

    addClass(table_cl, sortedTable)

    sortedTable.appendChild(tbodyRows[0])

    // add rows to tbody
    for (var i = 0; i < sortedRows.length; i++) {
        tbody.appendChild(sortedRows[i])
    }

    table.parentNode.replaceChild(sortedTable, table)
    sortedTable.insertBefore(thead, sortedTable.firstChild)

}

function compareRowsAsc(row1, row2) {
    var testTitle1 = row1.querySelector('td').textContent
    var testTitle2 = row2.querySelector('td').textContent

    if (testTitle1 < testTitle2) { return -1 }
    if (testTitle1 > testTitle2) { return 1 }
    return 0
}

function compareRowsDesc(row1, row2) {
    var testTitle1 = row1.querySelector('td').textContent
    var testTitle2 = row2.querySelector('td').textContent

    if (testTitle1 < testTitle2) { return 1 }
    if (testTitle1 > testTitle2) { return -1 }
    return 0
}

function addClass(arr, sortedTable) {
    for (var i = 0; i < arr.length; i++) {
        sortedTable.classList.add(arr[i])
    }
}

function addTbodyRows(sortedRows, tbodyRows) {
    for (var i = 0; i < tbodyRows.length; i++) {
        sortedRows.push(tbodyRows[i])
    }
}
