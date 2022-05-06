function find_marker(r::Robot)
  counter = 1
  while !ismarker(r)
      for i = 0:1
          move_side(r, counter, HorizonSide(i))
      end
      counter += 1
      for i = 2:3
          move_side(r, counter, HorizonSide(i))
      end
      counter += 1;
  end
end

function move_side(r::Robot, counter::Int, side::HorizonSide)
  for i = 1:counter
      if ismarker(r)
          break
      end
      move!(r, side)
  end
end