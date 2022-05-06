function mark_kross(r)
    side_hor = West
    side_vert = Nord
    putmarkers!(r, side_hor, side_vert)
    move_by_markers(r, inverse(side_hor), inverse(side_vert))
    side_hor = inverse(side_hor)
    putmarkers!(r, side_hor, side_vert)
    move_by_markers(r, inverse(side_hor), inverse(side_vert))
    side_vert = inverse(side_vert)
    putmarkers!(r, side_hor, side_vert)
    move_by_markers(r, inverse(side_hor), inverse(side_vert))
    side_hor = inverse(side_hor)
    putmarkers!(r, side_hor, side_vert)
    move_by_markers(r, inverse(side_hor), inverse(side_vert))
    putmarker!(r)
end

function putmarkers!(r::Robot, side_hor::HorizonSide, side_vert::HorizonSide)
    while !isborder(r, side_hor) && !isborder(r, side_vert)
        move!(r, side_hor);
        move!(r, side_vert)
        putmarker!(r)
    end
end

function move_by_markers(r::Robot, side_hor::HorizonSide, side_vert::HorizonSide)
    while ismarker(r)
        move!(r, side_hor);
        move!(r, side_vert)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))