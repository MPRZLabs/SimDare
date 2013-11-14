function love.load()
  sprites = {
    love.graphics.newImage("human.png"),
    love.graphics.newImage("computer.png"),
    love.graphics.newImage("room.png"),
    love.graphics.newImage("bed.png"),
    love.graphics.newImage("fridge.png"),
    love.graphics.newImage("doorc.png"),
    love.graphics.newImage("doorod.png"),
    love.graphics.newImage("dooron.png")
  }
  rainbowsy = love.image.newImageData("rainbow.png")
  sounds = {
    love.audio.newSource("track.ogg","stream"),
    love.audio.newSource("keys.ogg", "stream"),
    love.audio.newSource("sleep.ogg", "stream"),
    love.audio.newSource("food.ogg", "stream")
  }
  fonts = { }
  sounds[1]:setLooping(true)
  sounds[1]:setVolume(0.3)
  sounds[2]:setLooping(true)
  sounds[3]:setLooping(true)
  sounds[4]:setLooping(true)
  love.audio.play(sounds[1])
  occupation = 0
  timer = 48*60*60
  hours = 48
  minutes = 0
  lastminute = minutes
  food = 0.15
  conscience = 1
  overburn = 0
  sleep = 0.75
  workmlt = 1
  gamedone = -1
  clockr = 0
  clockg = 0
  clockb = 0
  fortunemod = {"You can do it!","Yay! You're making a game in a game!", "A few more (tens of) hours, and it will be done!", "hydsghyuerguyfdg", "howe784yr8dsf", "MOARRR COFFEEEE!!!", "People on IRC really like your idea.", "Why not code it in Malbolge or Brainfuck?"}
  math.randomseed(math.random(1,456))
  math.randomseed(math.random(1,456))
  math.randomseed(math.random(1,456))
  clockx = math.random(0, 799)
  clocky = math.random(0, 599)
  clockx = math.random(0, 799)
  clocky = math.random(0, 599)
  randomizeFortune()
  rainbowmode = 0
  getFont(15)
  getFont(18)
  getFont(40)
  love.graphics.setBackgroundColor(255, 255, 255, 255)
  performGameUpdate = true
end

function randomizeFortune()
  progressland = fortunemod[math.random(1,#fortunemod)]
end

function getFont(size)
  if fonts[size] then
    
  else
    fonts[size] = love.graphics.newFont(size)
  end
  return fonts[size]
end

function switchFont(size)
  love.graphics.setFont(getFont(size))
end

function love.update(dt)
  if gamedone < 0 then
    
  elseif gamedone < 1 then
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
      if conscience > 0.005*dt then
	conscience = conscience - 0.005*dt
      elseif conscience < 0.005*dt then
	conscience = 0
      end
      if occupation == 3 then
	sleep = sleep + 0.03*dt
	if sleep > 1 then
	  sleep = 1
	end
      elseif occupation == 2 then
	if conscience < 1 and conscience + 0.03*dt <= 1 then
	  conscience = conscience + 0.03*dt
	end
	if overburn > 0 and overburn - 0.03*dt >= 0 then
	  overburn = overburn - 0.03*dt
	elseif overburn < 0.03*dt then
	  overburn = 0
	end
      elseif occupation == 1 then
	if overburn < 1 and overburn + 0.01*dt <= 1 then
	  overburn = overburn + 0.01*dt
	elseif overburn + 0.01*dt > 1 then
	  overburn = 1
	end
	local stability = math.min(conscience, food, (1 - overburn), sleep)*workmlt
	if gamedone < 1 and gamedone + 0.01*dt*stability <=1 then
	  gamedone = gamedone + 0.01*dt*stability
	elseif gamedone + 0.01*dt*stability > 1 then
	  gamedone = 1
	end
      elseif occupation == 4 then
	if food < 1 and food + 0.2*dt <= 1 then
	  food = food + 0.2*dt
	elseif food + 0.2*dt > 1 then
	  food = 1
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
      if minutes%10 == 0 and (lastminute > minutes or lastminute < minutes) then
	randomizeFortune()
	lastminute = minutes
      end
    else
      love.audio.stop()
    end
    if food == 0 then
	performGameUpdate = false
    end
    if sleep == 0 then
      performGameUpdate = false
    end
    if timer <= 0 then
      performGameUpdate = false
    end
  end
end

function numToStr(int)
  if int < 10 then return "0"..int else return int end
end

function drawNeeds()
  if gamedone < 1 and gamedone > -1 then
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill", 0, 125, (1-food)*100, 50)
    love.graphics.rectangle("fill", 0, 225, (1-conscience)*100, 50)
    love.graphics.rectangle("fill", 0, 325, overburn*100, 50)
    love.graphics.rectangle("fill", 0, 425, (1-sleep)*100, 50)
    love.graphics.setColor(0,255,0,255)
    love.graphics.rectangle("fill", (1-food)*100, 125, food*100, 50)
    love.graphics.rectangle("fill", (1-conscience)*100, 225, conscience*100, 50)
    love.graphics.rectangle("fill", overburn*100, 325, (1-overburn)*100, 50)
    love.graphics.rectangle("fill", (1-sleep)*100, 425, sleep*100, 50)
    if rainbowmode > 0 then
      love.graphics.setColor(clockr, clockg, clockb, 255)
    else
      love.graphics.setColor(0,0,0,255)
    end
    switchFont(18)
    love.graphics.printf("Food", 0, 150, 100, "center")
    love.graphics.printf("Conscience", 0, 250, 100, "center")
    love.graphics.printf("Overwork", 0, 350, 100, "center")
    love.graphics.printf("Sleep", 0, 450, 100, "center")
  end
end

function drawProgress()
  if gamedone < 1 and gamedone > -1 then
    love.graphics.setColor(0,255,0,255)
    love.graphics.rectangle("fill", 200, 500, 400 * gamedone, 30)
    love.graphics.setColor(255,0,0,255)
    love.graphics.rectangle("fill", 200 + 400*gamedone, 500, 400 * (1-gamedone), 30)
    if rainbowmode > 0 then
      love.graphics.setColor(1-clockr, 1-clockg, 1-clockb, 255)
    else
      love.graphics.setColor(0,0,0,255)
    end
    love.graphics.printf(progressland, 200, 500, 400, "center")
  end
end

function drawTips()
  if rainbowmode > 0 then
    love.graphics.setColor(1-clockr, 1-clockg, 1-clockb, 255)
  else
    love.graphics.setColor(0,0,0,255)
  end
  switchFont(15)
  local x,y = love.mouse.getPosition()
  if x >= 212 and x <= 311 and y >= 188 and y <= 313 then
    love.graphics.printf("Bed", 600, 100, 100)
  end
  if x >= 539 and x <= 602 and y >= 189 and y <= 287 then
    love.graphics.printf("Computer", 600, 100, 100)
  end
  if x >= 335 and x <= 420 and y >= 0 and y <= 133 then
    love.graphics.printf("Outside", 600, 100, 100)
  end
  if x >= 534 and x <= 593 and y >= 351 and y <= 442 then
    love.graphics.printf("Fridge", 600, 100, 100)
  end
end

function drawClock()
  switchFont(40)
  if rainbowmode == 1 then
    local unchanged = true
    while unchanged do
      local dir = math.random(0,7)
      if dir == 0 then
	if clockx + 1 <= 799 then
	  clockx = clockx + 1
	  unchanged = false
	else
	  clockx = 799
	end
      elseif dir == 1 then
	if clocky + 1 <= 599 then
	  clocky = clocky + 1
	  unchanged = false
	else
	  clockx = 599
	end
      elseif dir == 2 then
	if clockx - 1 >= 0 then
	  clockx = clockx - 1
	  unchanged = false
	else
	  clockx = 0
	end
      elseif dir == 3 then
	if clocky - 1 >= 0 then
	  clocky = clocky - 1
	  unchanged = false
	else
	  clocky = 0
	end
      elseif dir == 4 then
	if clockx + 10 <= 799 then
	  clockx = clockx + 10
	  unchanged = false
	else
	  clockx = 799
	end
      elseif dir == 5 then
	if clocky + 10 <= 599 then
	  clocky = clocky + 10
	  unchanged = false
	else
	  clocky = 599
	end
      elseif dir == 6 then
	if clockx - 10 >= 0 then
	  clockx = clockx - 10
	  unchanged = false
	else
	  clockx = 0
	end
      elseif dir == 7 then
	if clocky - 10 >= 0 then
	  clocky = clocky - 10
	  unchanged = false
	else
	  clocky = 0
	end
      end
      print(dir .. " " .. clockx .. " " .. clocky)
    end
  elseif rainbowmode == 2 then
    clockx, clocky = love.mouse.getPosition()
  end
  clockr, clockg, clockb = rainbowsy:getPixel(clockx, clocky)
  love.graphics.setColor(255-clockr,255-clockg,255-clockb,255)
  love.graphics.printf(numToStr(hours) .. ":" .. numToStr(minutes), 50, 50, 115)
end
  
function drawSpeech()
  if rainbowmode > 0 then
    love.graphics.setColor(1-clockr, 1-clockg, 1-clockb, 255)
  else
    love.graphics.setColor(255,255,255,255)
  end
  if gamedone < 0 then
    switchFont(40)
    love.graphics.printf("SimDare", 480, 50, 200)
    switchFont(9)
    love.graphics.printf("Ludum Dare simulator", 480, 100, 300)
    local x, y = love.mouse.getPosition()
    switchFont(18)
    if x >= 100 and y >= 530 and x <= 300 and y <= 580 then
      love.graphics.rectangle("fill", 100, 530, 200, 50)
      if rainbowmode > 0 then
	love.graphics.setColor(clockr, clockg, clockb, 255)
      else
	love.graphics.setColor(0,0,0,255)
      end
      love.graphics.printf("Compo Mode", 100, 530, 200, "center")
    else
      love.graphics.rectangle("line", 100, 530, 200, 50)
      love.graphics.printf("Compo Mode", 100, 530, 200, "center")
    end
    if rainbowmode > 0 then
      love.graphics.setColor(1-clockr, 1-clockg, 1-clockb, 255)
    else
      love.graphics.setColor(255,255,255,255)
    end
    if x >= 500 and y >= 530 and x <= 700 and y <= 580 then
      love.graphics.rectangle("fill", 500, 530, 200, 50)
      if rainbowmode > 0 then
	love.graphics.setColor(clockr, clockg, clockb, 255)
      else
	love.graphics.setColor(0,0,0,255)
      end
      love.graphics.printf("Jam Mode", 500, 530, 200, "center")
    else
      love.graphics.rectangle("line", 500, 530, 200, 50) 
      love.graphics.printf("Jam Mode", 500, 530, 200, "center")
    end
  elseif gamedone < 1 then
    switchFont(17)
    if food == 0 then
      love.graphics.printf("You died of hunger :(", 200, 550, 500)
    end
    if sleep == 0 then
      love.graphics.printf("You fell asleep forever :(", 200, 550, 500)
    end
    if timer <= 0 then
      love.graphics.printf("You didn't make a game in time :(", 200, 550, 500)
    end
  else
    switchFont(40)
    love.graphics.printf("You made it!", 480, 50, 200)
    switchFont(15)
    love.graphics.printf("Congratulations, you finished your Ludum Dare entry on time, and managed not to die in process! Now go add some post-compo features!", 200, 550, 500)
    love.graphics.setColor(255,255,255,255)
  end
end

function love.draw()
  local x, y = love.mouse.getPosition()
  local colorstability = math.min(conscience, food, (1 - overburn), sleep)*255
  if rainbowmode > 0 then
    love.graphics.setColor(clockr, clockg, clockb, 255)
  else
    love.graphics.setColor(0,0,0,255)
  end
  love.graphics.draw(sprites[3], 0, 0)
  if x >= 539 and x <= 602 and y >= 189 and y <= 287 then
    love.graphics.setColor(180, 180, 180, 180)
  else
    love.graphics.setColor(120, 120, 120, 120)
  end
  love.graphics.draw(sprites[2], 571, 238, 0, 4, 4, 8, 12)
  love.graphics.setColor(255,255,255,255)
  if hours % 24 < 12 then
    door = sprites[7]
  else
    door = sprites[8]
  end
  if x >= 335 and x <= 420 and y >= 0 and y <= 133 then
    love.graphics.draw(door, 335, 1, 0, 4, 4)
    if occupation == 2 then
      love.graphics.setColor(colorstability,colorstability,colorstability,255)
      love.graphics.draw(sprites[1], 380, 20, 0, 4, 4)
      love.graphics.setColor(255,255,255,255)
    end
  else
    love.graphics.draw(sprites[6], 335, 1, 0, 4, 4)
  end
  if x >= 212 and x <= 311 and y >= 188 and y <= 313 then
    love.graphics.setColor(255,255,255,255)
  else
    love.graphics.setColor(200,200,200,255)
  end
  love.graphics.draw(sprites[4], 220, 300, math.rad(-70), 5)
  love.graphics.setColor(colorstability,colorstability,colorstability,255)
  if occupation == 3 then
    love.graphics.draw(sprites[1], 270, 200, math.rad(20), 4)
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
  drawTips()
  drawNeeds()
  drawClock()
  drawSpeech()
  drawProgress()
end

function love.keypressed(k)
  if k == "escape" then
    love.event.push('quit')
  end
end

function love.mousereleased(x, y,  button)
  if gamedone > -1 and gamedone < 1 and performGameUpdate then
    if button == "l" then
      if x >= 212 and x <= 311 and y >= 188 and y <= 313 then
	occupation = 3
	love.audio.pause(sounds[2])
	love.audio.play(sounds[3])
	love.audio.pause(sounds[4])
      end
      if x >= 539 and x <= 602 and y >= 189 and y <= 287 then
	occupation = 1
	love.audio.play(sounds[2])
	love.audio.pause(sounds[3])
	love.audio.pause(sounds[4])
      end
      if x >= 335 and x <= 420 and y >= 0 and y <= 133 then
	occupation = 2
	love.audio.pause(sounds[2])
	love.audio.pause(sounds[3])
	love.audio.pause(sounds[4])
      end
      if x >= 534 and x <= 593 and y >= 351 and y <= 442 then
	occupation = 4
	love.audio.pause(sounds[2])
	love.audio.pause(sounds[3])
	love.audio.play(sounds[4])
      end
    end
  elseif gamedone == -1 then
    if button == "l" then
      if x >= 100 and y >= 530 and x <= 300 and y <= 580 then
	gamedone = 0
	occupation = 3
	love.audio.play(sounds[3])
      end
      if x >= 500 and y >= 530 and x <= 700 and y <= 580 then
	timer = 72*60*60
	hours = 72
	gamedone = 0
	occupation = 3
	workmlt = 2/3
	love.audio.play(sounds[3])
      end
    end
  end
  if button == "m" then
    print(x .. " " .. y)
    if rainbowmode < 2 then
      rainbowmode = rainbowmode + 1
    else
      rainbowmode = 0
    end
  end
end