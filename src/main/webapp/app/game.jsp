<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Ship Placement</title>
    <style>
        table {
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        td {
            width: 20px;
            text-align: center;
        }
        td.SHIP {
            background-color: greenyellow;
        }
        td.MISS {
            background-color: aqua;
        }
        td.HIT {
            background-color: red;
        }
    </style>
</head>
<body onload="checkStatus()">
<div id="wait-another" class="w3-hide">
    <h1>Please wait another player</h1>
</div>
<div id="no-target" class="w3-hide">
    <h1>Please Select Target address</h1>
</div>
<div style="display: inline-block">
    <table>
        <tr>
            <td>&nbsp;</td>
            <c:forTokens items="A,B,C,D,E,F,G,H,I,J" delims="," var="col">
                <td><c:out value="${col}"/></td>
            </c:forTokens>
        </tr>
        <c:forTokens items="1,2,3,4,5,6,7,8,9,10" delims="," var="row">
            <tr>
                <td><c:out value="${row}"/></td>
                <c:forTokens items="A,B,C,D,E,F,G,H,I,J" delims="," var="col">
                    <td id="t${col}${row}"><input name="addr" type="radio" id="${col}${row}"/></td>
                </c:forTokens>
            </tr>
        </c:forTokens>
    </table>
</div>
<div style="display: inline-block">
    <table>
        <tr>
            <td>&nbsp;</td>
            <c:forTokens items="A,B,C,D,E,F,G,H,I,J" delims="," var="col">
                <td><c:out value="${col}"/></td>
            </c:forTokens>
        </tr>
        <c:forTokens items="1,2,3,4,5,6,7,8,9,10" delims="," var="row">
            <tr>
                <td><c:out value="${row}"/></td>
                <c:forTokens items="A,B,C,D,E,F,G,H,I,J" delims="," var="col">
                    <td id="m${col}${row}">&nbsp;</td>
                </c:forTokens>
            </tr>
        </c:forTokens>
    </table>
</div>


<div id="select-fire" class="w3-hide">
    <button type="button" onclick="fire()">Fire!</button>
</div>
<script>
    function checkStatus() {
        console.log("checking status");
        fetch("<c:url value='/api/game/status'/>", {
            "method": "GET",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then(function (response) {
            return response.json();
        }).then(function (game) {
            console.log(JSON.stringify(game));
            if (game.status === "STARTED" && game.playerActive) {
                document.getElementById("wait-another").classList.add("w3-hide");
                document.getElementById("select-fire").classList.remove("w3-hide");
                setRadioButtonsVisible(true);
            } else if (game.status === "STARTED" && !game.playerActive) {
                document.getElementById("wait-another").classList.remove("w3-hide");
                document.getElementById("select-fire").classList.add("w3-hide");
                setRadioButtonsVisible(false);
                window.setTimeout(function () {
                    checkStatus();
                }, 1000);
            } else
                return;
            drawField();
        });
    }
    function fire() {
        console.log("Fire!");
        var checked = document.querySelector('input[name=addr]:checked');
        var checkedAddr = checked.id;
        console.log("Fireing at ID - " + checkedAddr);
        fetch("<c:url value='/api/game/fire'/>/" + checkedAddr, {
            "method": "POST",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then(function (response) {
            console.log("DONE");
            checkStatus();
        });
    }

    function setRadioButtonsVisible(visible) {
        var radioButtons = document.querySelectorAll('input[name=addr]');
        radioButtons.forEach(function (button) {
            if (visible)
                button.classList.remove("w3-hide");
            else
                button.classList.add("w3-hide");
        })
    }

    function drawField() {
        console.log("Draw Field!");
        fetch("<c:url value='/api/game/cells'/>", {
            "method": "GET",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then(function (response) {
            return response.json();
        }).then(function (cells) {
            console.log(JSON.stringify(cells));
            cells.forEach(function (currentCell) {
                var id = (currentCell.targetArea ? "t" : "m") + currentCell.address;
                var tblCell = document.getElementById(id);
                tblCell.className = currentCell.state;
            });
        });
    }
</script>

</body>
</html>
