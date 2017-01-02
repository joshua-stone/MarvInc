name = "Tile Organizer"
n = "not decided"

lines_on_terminal = 40
memory_slots = 5

-- Bot
bot = {'b', 'EAST'}

-- name, draw background, image
o = {'obst', false, 'wall_none'}
k = {'bucket', true, 'bucket'}

local floor, objs

--This obviously won't be buckets in the final game.
objective_text = "Move the buckets from the top gray tiles to the bottom gray tiles, mirrored by the black line in the center"
function objective_checker(room)
    for i = 1, 20 do
        for j = 1, 20 do
            local p = 20 * (i - 1) + j
            local o = room.grid_obj[j][22 - i]
            if objs:sub(p, p) == 'k' and (not o or o.tp ~= 'bucket') then
                return false
            end
        end
    end
    return true
end

extra_info = "Remember you can't walk through a bucket"

grid_obj =  "oooooooooooooooooooo"..
            "oooooooooooooooooooo"..
            "o..................o"..
            "o.k.kk....k.k.kkkk.o".. -- 4
            "o...kk..k....kk.kk.o".. -- 5
            "o.kkkkk.....k..k...o".. -- 6
            "o....k...k.kk.kk...o".. -- 7
            "o.kk.kk....kkkk.kk.o".. -- 8
            "o.kkkk..k..k.kkk.k.o".. -- 9
            "o..k.k..k.kkk.kkkk.o".. -- 10
            "o.b,,,,,,,,,,,,,,,.o".. -- 11 -- MIRROR
            "o..................o".. -- 12
            "o..................o".. -- 13
            "o..................o".. -- 14
            "o..................o".. -- 15
            "o..................o".. -- 16
            "o..................o".. -- 17
            "o..................o".. -- 18
            "o..................o"..
            "oooooooooooooooooooo"
objs = grid_obj

-- Floor
w = "white_floor"
_G.getfenv()[','] = "black_floor"
r = "grey_tile"
g = "grey_tile"


grid_floor = "oooooooooooooooooooo"..
             "oooooooooooooooooooo"..
             "o,,,,,,,,,,,,,,,,,,o"..
             "o,gggggggggggggggg,o"..
             "o,gggggggggggggggg,o"..
             "o,gggggggggggggggg,o"..
             "o,gggggggggggggggg,o"..
             "o,gggggggggggggggg,o"..
             "o,gggggggggggggggg,o"..
             "o,gggggggggggggggg,o"..
             "o,,,,,,,,,,,,,,,,,,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,rrrrrrrrrrrrrrrr,o"..
             "o,,,,,,,,,,,,,,,,,,o"..
             "oooooooooooooooooooo"
floor = grid_floor
