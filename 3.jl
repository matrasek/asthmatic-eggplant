function mark_plane!(r::Robot)
  num_vert = moves!(r, Sud)
  num_hor = moves!(r, West)
  put_all_markers(r)
  moves!(r, Sud);
  moves!(r, West);
  moves!(r, Nord, num_vert)
  moves!(r, Ost, num_hor)
end

function put_all_markers(r::Robot)
  while !isborder(r, Ost)
      while !isborder(r, Nord)
          putmarker!(r)
          move!(r, Nord)
      end

      putmarker!(r)
      
      if !isborder(r, Ost) 
          move!(r, Ost)
      end

      while !isborder(r, Sud)
          putmarker!(r)
          move!(r, Sud)
      end

      putmarker!(r)

      if !isborder(r, Ost)
          move!(r, Ost)
      end
  end
end

function moves!(r::Robot, side::HorizonSide)
  num_steps = 0

  while !isborder(r,side)
      move!(r,side)
      num_steps += 1
  end

  return num_steps
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
  for i in 1:num_steps
      move!(r,side)
  end
end