function mark_plane(r::Robot)
  cnt_hor = moves!(r, West)
  cnt_vert = moves!(r, Sud)

  color =  mod(cnt_hor + cnt_vert, 2)
  put_all_markers(r, color)

  moves!(r, Sud)
  move_back(r, Ost, cnt_hor)
  move_back(r, Nord, cnt_vert)
end

function put_all_markers(r::Robot, color::Int)
  while true
      while !isborder(r, Ost)
          if color == 0
              putmarker!(r)
              color = 1
          else
              color = 0
          end
          move!(r, Ost)
      end

      if !check_last(r)
          move!(r, Ost)
          putmarker!(r)
      end

      moves!(r, West)

      if !isborder(r, Nord)
          move!(r, Nord)
      else
          break
      end
  end
end

function check_last(r::Robot)
  move!(r, West)
  return ismarker(r)
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