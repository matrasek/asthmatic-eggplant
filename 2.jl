function mark_perimetr!(r::Robot)
  num_vert = moves!(r, Sud)
  num_hor = moves!(r, West)
  for i in (Ost, Nord, West, Sud)
    putmarkers!(r, i)
  end
  moves!(r, Nord, num_vert)
  moves!(r, Ost, num_hor)
end

function moves!(r::Robot, side::HorizonSide)
  num_steps = 0
  while isborder(r, side) == false
      move!(r, side)
      num_steps += 1
  end
  return num_steps
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
  for i in 1:num_steps
      move!(r, side)
  end
end


function putmarkers!(r::Robot, side::HorizonSide)
  while !isborder(r, side)
      move!(r, side)
      putmarker!(r)
  end
end