function slowPrint(message)
   for i = 1, #message do
      local char = message:sub(i, i)
      io.write(char)
      os.sleep(0.05)
   end
   print()
end

function getFuel(totalBlocks)
   FuelLevel = turtle.getFuelLevel() / 80
   FuelNeeded = math.ceil((totalBlocks - FuelLevel) / 80)
   local bypass = false
   print("Fuel level: " .. FuelLevel)
   print("Coal needed: " .. FuelNeeded)
   print("Would you like to bypass the fuel check? (y/n)")
   local input = read()
   if input == "y" then
      bypass = true
   end
   while bypass ~= true do
      if FuelNeeded > FuelLevel then
         print("Place fuel in slot 1 and hit enter")
         read()
         turtle.select(1)
         turtle.refuel(64)
         FuelLevel = turtle.getFuelLevel()
         print("Fuel level: " .. FuelLevel)
         FuelNeeded = math.ceil((totalBlocks - FuelLevel) / 80)
         print("Coal needed: " .. FuelNeeded)
      else
         return
      end
   end
end

function getTotalBlocks(yLevel)
   local startY = yLevel
   TotalBlocks = (startY + 64) * 16 ^ 2
   slowPrint(TotalBlocks .. " blocks will be mined.")
   return TotalBlocks
end

function getCoords()
   local x, y, z = gps.locate()
   return x, y, z
end

function dumpInventory()
   for i = 1, 16 do
      turtle.select(i)
      local item = turtle.getItemDetail()
      if item ~= nil and item.name == "minecraft:coal" and FuelNeeded > FuelLevel then
         turtle.refuel(64)
         FuelLevel = turtle.getFuelLevel() / 80
         FuelNeeded = math.ceil((TotalBlocks - FuelLevel) / 80)
      end
      turtle.drop()
   end
end

function unload()
   local currentX, currentY, currentZ = getCoords()
   local deltaY = 0
   local deltaZ = math.abs(math.abs(currentZ) - math.abs(StartZ))
   local deltaX = math.abs(math.abs(currentX) - math.abs(StartX))
   while currentY ~= StartY do
      turtle.up()
      currentY = currentY + 1
      deltaY = deltaY + 1
   end
   if Rotation == 1 then
      if math.abs(currentX) % 2 == 0 then
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         dumpInventory()
         turtle.turnLeft()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         for i = 1, deltaY do
            turtle.down()
         end
      else
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         dumpInventory()
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         for i = 1, deltaY do
            turtle.down()
         end
         turtle.turnRight()
      end
   end
   if Rotation == 2 then
      if math.abs(currentZ) % 2 ~= 0 then
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         dumpInventory()
         turtle.turnLeft()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaY do
            turtle.down()
         end
      else
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         dumpInventory()
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         for i = 1, deltaY do
            turtle.down()
         end
      end
   end
   if Rotation == 3 then
      if math.abs(currentX) % 2 ~= 0 then
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         dumpInventory()
         turtle.turnLeft()
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaY do
            turtle.down()
         end
      else
         turtle.turnLeft()
         turtle.turnLeft()

         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         dumpInventory()
         turtle.turnLeft()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         for i = 1, deltaY do
            turtle.down()
         end
      end
   end
   if Rotation == 4 then
      if math.abs(currentZ) % 2 == 0 then
         turtle.turnLeft()
         turtle.turnLeft()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         dumpInventory()
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         for i = 1, deltaY do
            turtle.down()
         end
      else
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         dumpInventory()
         turtle.turnLeft()
         turtle.turnLeft()
         for i = 1, deltaZ do
            turtle.forward()
         end
         turtle.turnRight()
         for i = 1, deltaX do
            turtle.forward()
         end
         turtle.turnRight()
         turtle.turnRight()
         for i = 1, deltaY do
            turtle.down()
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
   local _, block = turtle.inspect()
   if block.name == "minecraft:gravel" then
      turtle.dig()
   end
end

function mineLayer()
   for x = 0, 15 do
      for z = 1, 15 do
         mine()
      end
      if x % 2 == 0 then
         turtle.turnRight()
         mine()
         turtle.turnRight()
      elseif x ~= 15 then
         turtle.turnLeft()
         mine()
         turtle.turnLeft()
      else
         turtle.turnRight()
      end
   end
end

function mineChunk(startY, endY)
   Rotation = 1
   local currentX = 0
   local currentY = startY
   local currentZ = 0
   local firstLayer = true
   while currentY ~= endY do
      if Rotation == 5 then
         Rotation = 1
      end
      -- if firstLayer == true then
      --    for i = 1, 2 do
      --       turtle.digDown()
      --       turtle.down()
      --    end
      -- end
      if firstLayer == false then
         for i = 1, 3 do
            turtle.digDown()
            turtle.down()
         end
      end
      currentX, currentY, currentZ = getCoords()
      turtle.digDown()
      mineLayer()
      Rotation = Rotation + 1
      firstLayer = false
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
