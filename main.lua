gui = require "lib.Quickie"
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
  occupation = 3
  task = 2
  timer = 48*60*60
  hours = 48
  minutes = 0
  food = 0.5
  hydration = 0.5
  conscience = 1
  overburn = 0
  sleep = 0.75
  gui.mouse.disable()
  love.graphics.setNewFont(15)
end

function love.update(dt)
  arc.check_keys(dt)
  timer = timer - 8*60*dt
  if sleep > 0.01*dt then
    sleep = sleep - 0.01*dt
  elseif sleep < 0.01*dt then
    sleep = 0
  end
  if food > 0.01*dt then
    food = food - 0.01*dt
  elseif food < 0.01*dt then
    food = 0
  end
  if hydration > 0.01*dt then
    hydration = hydration - 0.01*dt
  elseif hydration < 0.01*dt then
    hydration = 0
  end
  if occupation == 3 and sleep < 1 then
    if task == 2 then
      sleep = sleep + 0.03*dt
    elseif task == 1 then
      sleep = sleep + 0.02*dt
    end
    if sleep > 1 then
      sleep = 1
    end
  elseif occupation == 2 then
    if task == 2 then
      if conscience < 1 and conscience + 0.01*dt <= 1 then
	conscience = conscience + 0.01*dt
      end
    elseif task == 1 then
      if overburn > 0 and overburn - 0.03*dt >= 0 then
	overburn = overburn - 0.03*dt
      elseif overburn < 0.03*dt then
	overburn = 0
      end
    end
  elseif occupation == 1 then
    
  end
  hours = math.floor(timer/3600)
  minutes = math.floor((timer%3600)/60)
  gui.Label{text = numToStr(hours) .. ":" .. numToStr(minutes), pos = {100, 100}}
  gui.group{grow = "down", pos = {0, 200}, function()
    gui.group{grow = "right", function()
      gui.Label{text = "food", size = {100}}
      gui.Slider{info = {value = food}}
    end}
    gui.group{grow = "right", function()
      gui.Label{text = "hydration", size = {100}}
      gui.Slider{info = {value = hydration}}
    end}
    gui.group{grow = "right", function()
      gui.Label{text = "conscience", size = {100}}
      gui.Slider{info = {value = conscience}}
    end}
    gui.group{grow = "right", function()
      gui.Label{text = "overburn", size = {100}}
      gui.Slider{info = {value = overburn}}
    end}
    gui.group{grow = "right", function()
      gui.Label{text = "sleep", size = {100}}
      gui.Slider{info = {value = sleep}}
    end}
  end}
end

function numToStr(int)
  if int < 10 then return "0"..int else return int end
end

function love.draw()
  arc.clear_key()
  love.graphics.draw(sprites[3], 0, 0)
  love.graphics.draw(sprites[2], 571, 238, 0, 4, 4, 8, 12)
  love.graphics.draw(sprites[4], 220, 300, math.rad(-70), 5)
  if occupation == 3 then
    love.graphics.draw(sprites[1], 270, 200, math.rad(20), 4)
  elseif occupation == 2 then
    love.graphics.draw(sprites[1], -100, -100, 0, 4, 4)
  elseif occupation == 1 then
    love.graphics.draw(sprites[1], 543, 226, 0, 4, 4)
  end
  gui.core.draw()
end

function love.keypressed(k, unicode)
  arc.set_key(k)
  if k == "escape" then
    love.event.push('quit')
  end
end