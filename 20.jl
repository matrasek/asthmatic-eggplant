using HorizonSideRobots

function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end
end
function moves!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

putmarkers!(r::Robot, side::HorizonSide) =
    while isborder(r, side) == false
        move!(r, side)  
        putmarker!(r)
    end

function move_by_markers(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

nextCounterClockwise(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))

function moveWhileCan(r::Robot, sides)
moved = true
while moved
    moved = false
    for side in sides
        if !isborder(r, side)
            move!(r, side)
            moved = true
        end
    end
end
end

function bypass(r::Robot, dir)
bypassDir = nextCounterClockwise(dir)
antiBypassDir = inverse(bypassDir)
numSteps = 0
while !isborder(r, bypassDir) && isborder(r, dir)
    move!(r, bypassDir)
    numSteps += 1
end
if isborder(r, dir) && isborder(r,bypassDir)
    moves!(r, antiBypassDir, numSteps)
    return false
end
move!(r, dir)
moves!(r, antiBypassDir, numSteps)
return true
end

function countSegments(r::Robot)
    ans = 0
    moveWhileCan(r, (West, Sud))
    dir = Ost
    ans += processRow(r, dir, Nord)
    while !isborder(r, Nord)
        move!(r, Nord)
        dir = inverse(dir)
        ans += processRow(r, dir, Nord)
    end
    moveWhileCan(r, (West, Nord))

    dir = Sud
    ans += processRow(r, dir, Ost)

    while !isborder(r, Ost)
        move!(r, Ost)
        dir = inverse(dir)
        ans += processRow(r, dir, Ost)
    end

    return ans - 2
end

function processRow(r::Robot, side, toCheckSide)
    cnt = 0
    flag = false
    while !isborder(r, side) || bypass(r, side)
        if isborder(r, toCheckSide)
            if !flag
                flag = true
                cnt += 1
            end
        else
            flag = false
        end
        if !isborder(r, side)
            move!(r, side)
        end
    end
    return cnt
end