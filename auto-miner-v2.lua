function slowPrint(message)
   for i = 1, #message do
      local char = message:sub(i, i)
      io.write(char)
      os.sleep(0.05)
   end
   print()
end

function getFuel(totalBlocks)
   FuelLevel = turtle.getFuelLevel()
   FuelNeeded = totalBlocks - FuelLevel
   local bypass = false
   print("Fuel level: " .. FuelLevel)
   if FuelLevel < totalBlocks then
      print("Coal needed: " .. math.ceil(FuelNeeded / 80))
      print("Would you like to bypass the fuel check? (y/n)")
      local input = read()
      if input == "y" then
         bypass = true
      end
      while bypass ~= true do
         if FuelNeeded > 0 then
            print("Place fuel in invetory then hit enter")
            read()
            for i = 1, 16 do
               turtle.select(i)
               turtle.refuel(64)
            end
            FuelLevel = turtle.getFuelLevel()
            print("Fuel level: " .. FuelLevel)
            FuelNeeded = totalBlocks - FuelLevel
            print("Coal needed: " .. math.ceil(FuelNeeded / 80))
         else
            return
         end
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
      --check if item is fuel and if fuel is needed
      for j = 1, #Fuel do
         if item ~= nil and item.name == Fuel[j] and FuelNeeded > FuelLevel then
            turtle.refuel(64)
            FuelLevel = turtle.getFuelLevel()
            FuelNeeded = math.ceil(TotalBlocks - FuelLevel)
         end
      end

      -- if item ~= nil and item.name == "minecraft:coal" and FuelNeeded > FuelLevel then
      --    turtle.refuel(64)
      --    FuelLevel = turtle.getFuelLevel() / 80
      --    FuelNeeded = math.ceil((TotalBlocks - FuelLevel) / 80)
      -- end
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
      for i = 1, 16 do
         turtle.select(i)
         local item = turtle.getItemDetail()
         for j = 1, #TrashBlocks do
            if item ~= nil and item.name == TrashBlocks[j] then
               turtle.drop()
            end
         end
      end
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
   while currentY > endY do
      if Rotation == 5 then
         Rotation = 1
      end
      term.clear()
      print(Rotation)
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
StartX, StartY, StartZ = getCoords()
TrashBlocks = { "minecraft:gravel", "minecraft:dirt", "minecraft:granite", "minecraft:diorite", "minecraft:andesite",
   "minecraft:cobblestone", "promenade:blunite", "minecraft:cobbled_deepslate", "minecraft:tuff", "promenade:asphalt",
   "twigs:rhyolite" }
Fuel = { "minecraft:coal", "minecraft:charcoal", "modern_industrialization:lignite_coal" }
if StartY == nil then
   print("Please run the program with a GPS signal.")
   return
end
local totalBlocks = getTotalBlocks(StartY)
local fuel = getFuel(totalBlocks)
slowPrint("Input ending Y level: ")
local endY = tonumber(read())
mineChunk(StartY, endY)
