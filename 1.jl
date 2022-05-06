function mark_kross(r)
  for side in (HorizonSide(i) for i = 0:3)
      num = putmarkers!(r, side)
      moves!(r, inverse(side), num)
  end
  putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
  num = 0
  while !isborder(r, side)
      move!(r, side)
      num += 1
      putmarker!(r)
  end
  return num
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
  for i in 1:num_steps
      move!(r, side)
  end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))