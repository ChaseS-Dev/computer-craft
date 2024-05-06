function slowPrint (message)
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
   local totalBlocks = (startY + 64) * 16^2
   slowPrint(totalBlocks .. " blocks will be mined.")
   return totalBlocks
end

function mine()
   while not turtle.forward() do
      turtle.dig()
   end
   turtle.digUp()
   turtle.digDown()
end

--Main program
local endY = -123
local startX, startY, startZ = gps.locate()
if startY == nil then
   print("Please run the program with a GPS signal.")
   return
end
local totalBlocks = getTotalBlocks(startY)
local fuel = getFuel(totalBlocks)

--Mine layer
local currentY = startY
while currentY >= endY do
   for i = 1, 16 do
      for j = 1, 16 do
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


