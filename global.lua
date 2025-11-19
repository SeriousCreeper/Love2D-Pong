local StateGame = require("states/state_game")
local StateMainMenu = require("states/state_main_menu")

Global = {
    playerScore = 0,
    enemyScore = 0,
    playerCount = 1,
    cameras = {
    }
}

Global.states = {
    game = StateGame,
    mainMenu = StateMainMenu
}

Global.currentState = Global.states.mainMenu

return Global