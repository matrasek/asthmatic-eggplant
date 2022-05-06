function mark_plane(r::Robot)
  cnt_hor = moves!(r, West)
  cnt_vert = moves!(r, Sud)

  len = moves!(r, Ost)
  moves!(r, West)

  put_all_markers(r, len)

  moves!(r, Sud)
  move_back(r, Ost, cnt_hor)
  move_back(r, Nord, cnt_vert)
end

function put_all_markers(r::Robot, len::Int)
  while true
      for i = 1:len
          putmarker!(r)
          move!(r, Ost)
      end
      putmarker!(r)

      moves!(r, West)

      if !isborder(r, Nord)
          move!(r, Nord)
      else
          break
      end

      len -= 1
  end
end

function moves!(r::Robot, side::HorizonSide)
  counter = 0
  while !isborder(r, side)
      move!(r, side)
      counter += 1
  end
  return counter
end

function move_back(r::Robot, side::HorizonSide, steps::Int)
  for i = 1:steps
      move!(r, side)
  end
end