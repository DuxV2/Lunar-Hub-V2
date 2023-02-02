local games = {
  [8579989858] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Super%20Clicker%20Simulator.lua",
  [11542692507] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Anime%20Souls%20Simulator.lua",
  [6516141723] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/DOORS.lua",
  [11063612131] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Every%20Second%20You%20Get%20%2B1%20Jump.lua",
  [11800876530] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Every%20Second%20You%20Get%20%2B1%20Blocks.lua",
  [11400511154] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Monkey%20Tycoon.lua",
  [8737602449] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/PLS%20DONATE.lua",
  [6918802270] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Project%20New%20World.lua",
  [9285238704] = "https://raw.githubusercontent.com/DuxV2/Lunar-Hub-V2/main/Games/Featured/Race%20Clicker.lua"
}

if games[game.PlaceId] then
    loadstring(game:HttpGet(games[game.PlaceId])()
else
    game.Players.LocalPlayer:Kick("Unsupported Game")
end
