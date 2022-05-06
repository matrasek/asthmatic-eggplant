function find_door(r::Robot)
  counter = 1
  while isborder(r, Nord)
      side = Ost
      move_side(r, counter, side)
      side = West
      move_side(r, counter, side)
      move_side(r, counter, side)
      side = Ost
      move_side(r, counter, side)
      counter += 1
  end
end

function move_side(r::Robot, counter::Int, side::HorizonSide)
  for i = 1:counter
      if !isborder(r, Nord)
          break
      end
      move!(r,side)
  end
end