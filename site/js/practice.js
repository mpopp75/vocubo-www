$("#entry").keyup(function(event) {
    if (event.keyCode === 13) {
        $("#sbutton").click();
    }
});

function sendAnswer(id) {
    var answer = document.getElementById('entry').value;

    $.ajax({
        type: "POST",
        url:  "ajax_requests/practice.php",
        data: "id=" + parseInt(id) + "&answer=" + answer,
        success: function(msg){

            var next = "<form action=\"practice.php\"><input type=\"submit\" value=\"Next\"></form>";

            $('div#reply').html(msg + next);
            $('div#question').html(answer);
        }
    });
}