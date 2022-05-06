function mark_corners(r::Robot)
  (a, cnt_hor, cnt_vert) = move_to_corner(r)    

  put_all_markers(r, cnt_hor, cnt_vert)
  move_to_corner(r)

  move_back(r, a)
end

function move_to_corner(r::Robot)
  i = 1
  a = []
  cnt_hor = 0
  cnt_vert = 0
  while !isborder(r, West) || !isborder(r, Sud)
      if mod(i, 2) == 0
          side = West
      else
          side = Sud
      end
      cnt = moves!(r, side)
      cnt_hor += mod(i + 1, 2) * cnt
      cnt_vert += mod(i, 2) * cnt
      push!(a, cnt)
      i += 1
  end
  return (a, cnt_hor, cnt_vert)
end

function put_all_markers(r::Robot, cnt_hor::Int, cnt_vert::Int)
  moves!(r, Ost, cnt_hor)
  putmarker!(r)
  moves!(r, Ost)
  moves!(r, Nord, cnt_vert)
  putmarker!(r)
  moves!(r, Sud)
  moves!(r, West)
  moves!(r, Nord, cnt_vert)
  putmarker!(r)
  moves!(r, Nord)
  moves!(r, Ost, cnt_hor)
  putmarker!(r)
end

function moves!(r::Robot, side::HorizonSide)
  counter = 0
  while !isborder(r, side)
      move!(r, side)
      counter += 1
  end
  return counter
end

function moves!(r::Robot, side::HorizonSide, steps::Int)
  for i = 1:steps
      move!(r, side)
  end
end

function move_back(r::Robot, a::Array)
  n = length(a)
  while n > 0
      if mod(n, 2) == 0
          side = Ost
      else
          side = Nord
      end
      for i = 1:a[n]
          move!(r, side)
      end
      n -= 1
  end
end