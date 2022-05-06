function find_average(r::Robot)
  (sum, count) = count_markers(r)
  if count == 0
      print(0)
  else
      print(sum / count)
  end
end

function count_markers(r::Robot)
  count = 0
  sum = 0
  side = Ost
  (n_sum, n_count) = check_line(r, side)
  sum += n_sum
  count += n_count
  while !isborder(r, Nord)
      move!(r, Nord)
      side = inverse(side)
      (n_sum, n_count) = check_line(r, side)
      sum += n_sum
      count += n_count
  end
  return (sum, count)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function check_line(r::Robot, side::HorizonSide)
  count = 0
  sum = 0
  while !isborder(r, side)
      if ismarker(r)
          count += 1
          sum += temperature(r)
      end
      move!(r, side)
  end

  if ismarker(r)
      count += 1
      sum += temperature(r)
  end

  return (sum, count)
end