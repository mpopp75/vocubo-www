$("#entry").keyup(function(event) {
    if (event.keyCode === 13 && $("#entry").val() !== "") {
        $("#sbutton").click();
    }
});

function sendAnswer(id) {
    var answer = document.getElementById('entry').value;
    var chartoggle = document.getElementById('chartoggle');
    var characters = document.getElementById('characters');

    $.ajax({
        type: "POST",
        url:  "requests/practice.php",
        data: "id=" + parseInt(id) + "&what=sendanswer&answer=" + answer,
        success: function(msg){

            var next = "<form action=\"practice.php\"><input type=\"submit\" value=\"Next\"></form>";

            $('div#reply').html(msg + next);
            $('div#question').html(answer);

            chartoggle.style.display = "none";
            characters.style.display = "none";

            getLog(id);
        }
    });
}

function getLog(id) {
    $.ajax({
        type: "POST",
        url:  "requests/practice.php",
        data: "id=" + parseInt(id) + "&what=getlog",
        success: function(msg){
            var html = "<table id=\"logtable\">";
            var log = JSON.parse(msg);

            for (var i = 0; i < log.length ; i++) {
                var result = "";
                if (log[i].result === "1") {
                    result = "<span style=\"color: green\">Correct</span>";
                } else {
                    result = "<span style=\"color: red\">False</span>";
                }
                var wrong_answer = "";
                if (log[i].wrong_answer === null) {
                    wrong_answer = "&nbsp;";
                } else {
                    wrong_answer = "<span style=\"color:red\">" + log[i].wrong_answer + "</span>";
                }
                html += "<tr>";
                html += "  <td>" + log[i].ts + "</td>";
                html += "  <td>" + result + "</td>";
                html += "  <td>" + wrong_answer + "</td>";
                html += "</tr>";
            }
            html += "</table>";
            $('div#log').html(html);
        }
    });
}

function toggleChars() {
    var characters = document.getElementById('characters');

    if(characters.style.display === "none") {
        characters.style.display = "block";
    } else {
        characters.style.display = "none";
    }
}

function getChar(char) {
    var entry = document.getElementById('entry');

    var selectionStart = entry.selectionStart;
    var selectionEnd = entry.selectionEnd;

    entry.value = entry.value.substring(0, selectionStart) + char + entry.value.substring(selectionEnd, entry.length);
    entry.selectionStart = selectionStart + 1;
    entry.selectionEnd = selectionStart + 1;

    entry.focus();
}
