function slowPrint(message)
   for i = 1, #message do
      local char = message:sub(i, i)
      io.write(char)
      os.sleep(0.05)
   end
   print()
end

function getFuel(totalBlocks)
   local fuelLevel = turtle.getFuelLevel()
   local fuelNeeded = math.ceil((totalBlocks - fuelLevel) / 80)
   local bypass = false
   print("Fuel level: " .. fuelLevel)
   print("Coal needed: " .. fuelNeeded)
   print("Would you like to bypass the fuel check? (y/n)")
   local input = read()
   if input == "y" then
      bypass = true
   end
   while bypass ~= true do
      if fuelNeeded > fuelLevel then
         print("Place fuel in slot 1 and hit enter")
         read()
         turtle.select(1)
         turtle.refuel(64)
         fuelLevel = turtle.getFuelLevel()
         print("Fuel level: " .. fuelLevel)
         fuelNeeded = math.ceil((totalBlocks - fuelLevel) / 80)
         print("Coal needed: " .. fuelNeeded)
      else
         return
      end
   end
end

function getTotalBlocks(yLevel)
   local startY = yLevel
   local totalBlocks = (startY + 64) * 16 ^ 2
   slowPrint(totalBlocks .. " blocks will be mined.")
   return totalBlocks
end

function getCoords()
   local x, y, z = gps.locate()
   return x, y, z
end

function unload()
   local currentX, currentY, currentZ = getCoords()
   while currentY ~= StartY do
      turtle.up()
   end
   if Rotation == 1 then
      if currentX % 2 == 0 then
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, abs(currentZ) - abs(StartZ) do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, abs(currentX) - abs(StartX) do
            turtle.forward()
         end
      end
   end
end

function mine()
   if turtle.getItemCount(16) ~= 0 then
      unload()
      turtle.select(1)
   end
   while not turtle.forward() do
      turtle.dig()
   end
   turtle.digUp()
   turtle.digDown()
end

function mineLayer()
   for i = 1, 16 do
      for j = 1, 15 do
         mine()
      end
      if i % 2 == 0 then
         turtle.turnLeft()
         mine()
         turtle.turnLeft()
      else
         turtle.turnRight()
         mine()
         turtle.turnRight()
      end
   end
end

function mineChunk(startY, endY)
   Rotation = 1
   local currentX = 0
   local currentY = startY
   local currentZ = 0
   while currentY ~= endY do
      currentX, currentY, currentZ = getCoords()
      for i = 1, 2 do
         turtle.digDown()
         turtle.down()
      end
      turtle.digDown()
      mineLayer()
      turtle.turnRight()
      Rotation = Rotation + 1
      if Rotation == 4 then
         Rotation = 1
      end
   end
end

--Main program
local endY = -123
StartX, StartY, StartZ = getCoords()
if StartY == nil then
   print("Please run the program with a GPS signal.")
   return
end
local totalBlocks = getTotalBlocks(StartY)
local fuel = getFuel(totalBlocks)
mineChunk(StartY, endY)
