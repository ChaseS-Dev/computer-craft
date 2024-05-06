--TODO: Add ability to use other fuels
--TODO: Return to start if unable to mine block
--TODO: Add ability to refuel on the fly


-- Desc: A turtle script that mines a 16x16 chunk of blocks
local function slowPrint (message)
   for i = 1, #message do
      local char = message:sub(i, i)
      io.write(char)
      os.sleep(0.05)
   end
   print()
end

local function getFuel(totalBlocks)   
   local fuelLevel = turtle.getFuelLevel()
   local fuelNeeded = math.ceil((totalBlocks - fuelLevel) / 80)
   local bypass = false
   if fuelNeeded < fuelLevel then
      slowPrint("Fuel level: " .. fuelLevel)
      slowPrint("Coal needed: " .. fuelNeeded)
      slowPrint("Please place fuel in slot 1 and hit enter")
      read()
   end
   while fuelNeeded < fuelLevel do
      turtle.select(1)
      turtle.refuel(64)
      if bypass == false then
         slowPrint("Fuel level: " .. fuelLevel)
         slowPrint("If you would like to bypass this check, type 'bypass'")
         slowPrint("Or insert more fuel and hit enter")
         local input = read()
         if input == "bypass" then
            return
         end
      end
   end
end

local function getEndY(yLevel)
   local startY = yLevel + 64
   local endY = startY + (startY - 5)
   local totalBlocks = endY * 16^2
   slowPrint(totalBlocks .. " blocks will be mined.")
   getFuel(totalBlocks)
   return endY
end

--Function to return to check if last inventory slot has items then return to chest and unload items
local function unload(x, y, z)
   for i = 1, y - 1 do
      turtle.up(y - 1)
   end
   if x % 2 == 0 then
      turtle.turnRight()
      turtle.forward()
      turtle.turnLeft()
      for i = 1, 16 - z do
         turtle.forward()
      end
      turtle.turnRight()
      for i = 1, x do
         turtle.forward()
      end
      turtle.turnLeft()
      for i = 1, 16 do
         turtle.select(i)
         turtle.drop()
      end
      turtle.turnLeft()
      turtle.turnLeft()
      for i = 1, 16 - z do
         turtle.forward()
      end
      turtle.turnRight()
      for i = 1, x - 1 do
         turtle.forward()
      end
      turtle.turnRight()
      for i = 1, y - 1 do
         turtle.down()
      end
   else
      turtle.turnLeft()
      turtle.turnLeft()
      for i = 1, z do
         turtle.forward()
      end
      turtle.turnRight()
      for i = 1, x do
         turtle.forward()
      end
      turtle.turnLeft()
      for i = 1, 16 do
         turtle.select(i)
         turtle.drop()
      end
      turtle.turnLeft()
      for i = 1, x - 1 do
         turtle.forward()
      end
      turtle.turnLeft()
      if z ~= 1 then
         for i = 1, z do
            turtle.forward()
         end
      end
      for i = 1, y - 1 do
         turtle.down()
      end
   end
end


local function mine(yLevel)
   local endY = yLevel
   local turtleX = 1
   local turtleZ = 1
   local turtleY = 1
   for y = 1, endY do
      turtleY = y
      for x = 1, 16 do
         turtleX = x
         for z = 1, 15 do
            turtleZ = z
            if turtle.getItemCount(16) ~= 0 then
               unload(turtleX, turtleY, turtleZ)
               turtle.select(1)
            end
            while not turtle.forward() do
               turtle.dig()
            end
         end
         if x % 2 == 0 and x ~= 16 then
            turtle.turnLeft()
            while not turtle.forward() do
               turtle.dig()
            end
            turtle.turnLeft()
         elseif x % 2 == 1 and x ~= 16 then
            turtle.turnRight()
            while not turtle.forward() do
               turtle.dig()
            end
            turtle.turnRight()
         end
      end
      turtle.turnRight()
      for i = 1, 16 do
         turtle.forward()
      end
      turtle.turnRight()
      while not turtle.down() do
         turtle.digDown()
      end
   end
end



-- slowPrint("16x16 Chunk Miner")
-- slowPrint("Ensure you have placed your turtle in")
-- slowPrint("the south western corner of the chunk")
-- slowPrint("you want to mine.")
slowPrint("Please enter starting Y level: ")
local startY = read()
local endY = getEndY(startY)
mine(endY)


