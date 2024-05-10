function collect()
   for i = 1, 5 do
      turtle.suck()
      turtle.forward()
   end
   turtle.turnLeft()
   turtle.turnLeft()
   for i = 1, 5 do
      turtle.forward()
   end
   turtle.turnLeft()
   turtle.turnLeft()
   turtle.down()
   turtle.down()
   for i = 1, 5 do
      turtle.suck()
      turtle.forward()
   end
   turtle.turnLeft()
   turtle.turnLeft()
   for i = 1, 5 do
      turtle.forward()
   end
   turtle.up()
   turtle.up()
   turtle.turnLeft()
   for i = 1, 16 do
      turtle.select(i)
      turtle.drop()
   end
   turtle.turnLeft()
end

--Main
while true do
   collect()
   sleep(300)
end
