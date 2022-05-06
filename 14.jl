function move_back!(r::Robot, side::HorizonSide, num_steps::Int)
  while num_steps > 0
      move_if_possible!(r, side)
      num_steps -= 1
  end
end

function movements!(r::Robot, side::HorizonSide)
  while !isborder(r, side)
      move!(r, side)
  end 
end

function movements!(r::Robot, side::HorizonSide, num_steps::Int)
  for i in 1:num_steps
      move!(r, side)
  end 
end


function count_movements!(r::Robot, side::HorizonSide)
  num_steps = 0
  while !isborder(r, side) 
      move!(r, side) 
      num_steps += 1    
  end
  return num_steps
end


inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))


left(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))


right(side::HorizonSide) = HorizonSide(mod(Int(side) - 1, 4))

function move_if_possible!(r::Robot, now_side::HorizonSide)::Bool
  
  if !isborder(r, now_side)
      move!(r, now_side)
      return true
  end

  
  left_side = left(now_side)
  right_side = inverse(left_side)
  num_steps = 0

  back_steps = 0

  while isborder(r, now_side)
      if !isborder(r, left_side)
          move!(r, left_side)
          num_steps += 1
          back_steps += 1
      else
          movements!(r, right_side, back_steps)
          return false # робот пришел в угол
      end
  end

  move!(r, now_side)

  back_steps = 0

  while isborder(r, right_side)
      if !isborder(r, now_side)
          move!(r, now_side)
          back_steps += 1
      else
          movements!(r, left_side, back_steps)
          return false # робот пришел в угол
      end
  end

  for i in 1:num_steps
      move!(r, right_side)
  end 
  
  return true
end

function mark_kross(r)
    for side in 0:3
        num = putmarkers!(r, HorizonSide(side))
        move_back!(r, inverse(HorizonSide(side)), num)
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
    num = 0
    while move_if_possible!(r, side)
        putmarker!(r)
        num += 1
    end
    return num
end