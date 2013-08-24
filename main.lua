gui = require('lib.Quickie.gui')
arc_root = "lib/Navi/"
arc_path = arc_root .. "arc/"
require(arc_path.. "arc")
_navi = require(arc_path .. "navi")

function love.load()
  human = love.graphics.newImage("human.png")
  fonts = {
    [12] = love.graphics.newFont(12)
    [20] = love.graphics.newFont(20)
  }
  love.graphics.setFont(fonts[12])
end

function love.update(dt)
  current.update(dt)
end

function love.draw(dt)
  current.draw(dt)
end

function love.keypressed(k, unicode)
  
end

function love.keyreleased(k, unicode)
  
end