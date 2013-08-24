arc_root = "lib/Navi/"
arc_path = arc_root .. "arc/"
require(arc_path.. "arc")
_navi = require(arc_path .. "navi")

function love.load()
  sprites = {
    love.graphics.newImage("human.png"),
    love.graphics.newImage("computer.png"),
    love.graphics.newImage("room.png"),
    love.graphics.newImage("bed.png")
  }
  fonts = {
    [12] = love.graphics.newFont(12),
    [20] = love.graphics.newFont(20)
  }
  love.graphics.setFont(fonts[12])
end

function love.update(dt)
  arc.check_keys(dt)
  
end

function love.draw()
  arc.clear_key()
  love.graphics.draw(sprites[3], 0, 0)
  love.graphics.draw(sprites[2], 571, 238, 0, 4, 4, 8, 12)
  love.graphics.draw(sprites[4], 220, 300, -70, 5)
end

function love.keypressed(k, unicode)
  arc.set_key(k)
end

