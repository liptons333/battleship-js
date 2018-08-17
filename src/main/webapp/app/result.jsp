<%--
  Created by IntelliJ IDEA.
  User: kristaps.lipsha01
  Date: 8/17/2018
  Time: 10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Result</title>
</head>
<body onload="checkStatus()">
    <h1>Thanks for Game</h1>
    <div id="player-win" class="w3-hide">
        <h1>You win!</h1>
    </div>
    <div id="player-lose" class="w3-hide">
        <h1>You lose!</h1>
    </div>
    <button type="button" onclick="logout()">Log out</button>
    <button type="button" onclick="startGame()">Start Game</button>
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

            if (game.playerActive) {
                document.getElementById("player-lose").classList.add("w3-hide");
                document.getElementById("player-win").classList.remove("w3-hide");
            } else if (!game.playerActive) {
                document.getElementById("player-lose").classList.remove("w3-hide");
                document.getElementById("player-win").classList.add("w3-hide");
            }
        });
    }

    function logout() {
        fetch("<c:url value='/api/auth/logout'/>", {"method": "POST"})
            .then(function (response) {
                location.href = "/";
            });
    }

    function startGame() {
        fetch("<c:url value='/api/game'/>", {"method": "POST"})
            .then(function (response) {
                location.href = "/app/placement.jsp";
            });
    }
</script>
</body>
</html>
