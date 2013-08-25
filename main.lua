gui = require "lib.Quickie"

function love.load()
  sprites = {
    love.graphics.newImage("human.png"),
    love.graphics.newImage("computer.png"),
    love.graphics.newImage("room.png"),
    love.graphics.newImage("bed.png"),
    love.graphics.newImage("fridge.png")
  }
  occupation = 3
  task = 2
  timer = 48*60*60
  hours = 48
  minutes = 0
  food = 0.15
  hydration = 0.15
  conscience = 1
  overburn = 0
  sleep = 0.75
  gamedone = 0
  gui.mouse.disable()
  fonts = {
    [15] = love.graphics.newFont(15),
    [40] = love.graphics.newFont(40)
  }
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  performGameUpdate = true
end

function love.update(dt)
  if gamedone < 1 then
    if performGameUpdate then
      timer = timer - 8*60*dt
      if timer <= 0 then
	performGameUpdate = false
      end
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
      if hydration > 0.015*dt then
	hydration = hydration - 0.015*dt
      elseif hydration < 0.015*dt then
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
	if task == 2 then
	  if overburn < 1 and overburn + 0.01*dt <= 1 then
	    overburn = overburn + 0.01*dt
	  elseif overburn + 0.01*dt > 1 then
	    overburn = 1
	  end
	  local stability = math.min(conscience, food, hydration, (1 - overburn), sleep)
	  if gamedone < 1 and gamedone + 0.01*dt*stability <=1 then
	    gamedone = gamedone + 0.01*dt*stability
	  elseif gamedone + 0.01*dt*stability > 1 then
	    gamedone = 1
	  end
	elseif task == 1 then
	  if overburn > 0 and overburn - 0.02*dt >= 0 then
	    overburn = overburn - 0.02*dt
	  elseif overburn < 0.02*dt then
	    overburn = 0
	  end
	end
      elseif occupation == 4 then
	if task == 2 then
	  if food < 1 and food + 0.2*dt <= 1 then
	    food = food + 0.2*dt
	  elseif food + 0.2*dt > 1 then
	    food = 1
	  end
	  if hydration < 1 and hydration + 0.4*dt <= 1 then
	    hydration = hydration + 0.4*dt
	  elseif hydration + 0.4*dt > 1 then
	    hydration = 1
	  end
	end
      end
      if occupation > 1 then
	if overburn > 0 and overburn - 0.01*dt >= 0 then
	  overburn = overburn - 0.01*dt
	elseif overburn < 0.01*dt then
	  overburn = 0
	end
      end
      if gamedone == 1 then
	performGameUpdate = false
      end
      hours = math.floor(timer/3600)
      minutes = math.floor((timer%3600)/60)
    end
    if food == 0 then
	performGameUpdate = false
	gui.Label{text = "You died of hunger", pos = {100, 500}, size = {100}}
    end
    if hydration == 0 then
      performGameUpdate = false
      gui.Label{text = "You died of dehydration", pos = {100, 525}, size = {100}}
    end
    if sleep == 0 then
      performGameUpdate = false
      gui.Label{text = "You fell asleep forever", pos = {100, 550}, size = {100}}
    end
    if timer <= 0 then
      performGameUpdate = false
      gui.Label{text = "You didn't make a game in time :(", pos = {100, 475}, size = {100}}
    end
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
    gui.group{grow = "down", pos = {380, 530}, function()
      gui.Label{text = "progress", size= {100}}
      gui.Slider{info = {value = gamedone}, size = {400}}
    end}
    x, y = love.mouse.getPosition()
    if x >= 212 and x <= 311 and y >= 188 and y <= 313 then
      gui.Label{text = "Bed", pos = {600, 100}, size = {100}}
    end
    if x >= 539 and x <= 602 and y >= 189 and y <= 287 then
      gui.Label{text = "Computer", pos = {600, 100}, size = {100}}
    end
    if x >= 333 and x <= 421 and y >= 0 and y <= 144 then
      gui.Label{text = "Outside", pos = {600, 100}, size = {100}}
    end
    if x >= 534 and x <= 593 and y >= 351 and y <= 442 then
      gui.Label{text = "Fridge", pos = {600, 100}, size = {100}}
    end
  else
    love.graphics.setFont(fonts[40])
    gui.Label{text = "You made it!", pos = {480, 50}}
    love.graphics.setFont(fonts[15])
    gui.group{grow = "down", pos = {100, 500}, function()
      gui.Label{text = "you just won SimDare, Michcioperz's 1st Ludum entry he's proud of"}
      gui.Label{text = "Michcioperz would love to hear your feedback on Twitter"}
      gui.Label{text = "thanks for playing and good luck with your Ludum"}
    end}
  end
end

function numToStr(int)
  if int < 10 then return "0"..int else return int end
end


function love.draw()
  local x, y = love.mouse.getPosition()
  if x >= 333 and x <= 421 and y >= 0 and y <= 144 then
    love.graphics.setColor(180, 180, 180, 180)
  else
    love.graphics.setColor(120, 120, 120, 120)
  end
  love.graphics.rectangle("fill", 300, 0, 150, 144)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(sprites[3], 0, 0)
  if x >= 539 and x <= 602 and y >= 189 and y <= 287 then
    love.graphics.setColor(180, 180, 180, 180)
  else
    love.graphics.setColor(120, 120, 120, 120)
  end
  love.graphics.draw(sprites[2], 571, 238, 0, 4, 4, 8, 12)
  if x >= 212 and x <= 311 and y >= 188 and y <= 313 then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(200,200,200,255)
  end
  love.graphics.draw(sprites[4], 220, 300, math.rad(-70), 5)
  local colorstability = math.min(conscience, food, hydration, (1 - overburn), sleep)*255
  love.graphics.setColor(colorstability,colorstability,colorstability,255)
  if occupation == 3 then
    love.graphics.draw(sprites[1], 270, 200, math.rad(20), 4)
  elseif occupation == 2 then
    love.graphics.draw(sprites[1], -100, -100, 0, 4, 4)
  elseif occupation == 1 then
    love.graphics.draw(sprites[1], 543, 226, 0, 4, 4)
  elseif occupation == 4 then
    love.graphics.draw(sprites[1], 543, 348, math.rad(30), 4, 4)
  end
  if x >= 534 and x <= 593 and y >= 351 and y <= 442 then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(200,200,200,255)
  end
  love.graphics.draw(sprites[5], 533, 348, 0, 4, 4)
  love.graphics.setColor(255, 255, 255, 255)
  gui.core.draw()
end

function love.keypressed(k, unicode)
  if k == "escape" then
    love.event.push('quit')
  end
end

function love.mousereleased(x, y,  button)
  if button == "l" then
    if x >= 212 and x <= 311 and y >= 188 and y <= 313 then
      occupation = 3
      task = 2
    end
    if x >= 539 and x <= 602 and y >= 189 and y <= 287 then
      occupation = 1
      task = 2
    end
    if x >= 333 and x <= 421 and y >= 0 and y <= 144 then
      occupation = 2
      task = 1
    end
    if x >= 534 and x <= 593 and y >= 351 and y <= 442 then
      occupation = 4
      task = 2
    end
  elseif button == "m" then
    print(x .. " " .. y)
  end
end