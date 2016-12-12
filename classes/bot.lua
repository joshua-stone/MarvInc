require "classes.primitive"
local Color = require "classes.color.color"

-- Bot class

local bot = {}

Bot = Class{
    __includes = {Object},
    init = function(self, grid, i, j)
        self.steps = 0
        local trait1, trait2, trait3, trait_n

        -- i and j are 0-indexed positions in grid
        Object.init(self, grid, i, j, "bot", true)
        self.head = HEAD[love.math.random(#HEAD)]
        self.body = BODY[love.math.random(#BODY)]
        self.head_clr = Color.new(love.math.random(256) - 1, 200, 200)
        self.body_clr = Color.new(love.math.random(256) - 1, 200, 200)

        --Create 1-3 traits
        self.traits = {}

        -- Number of traits
        trait_n = love.math.random(3)

        -- Trait 1
        trait1 = TRAITS[love.math.random(#TRAITS)]
        table.insert(self.traits, trait1)

        -- Trait 2
        if trait_n > 1 then
            trait2 = TRAITS[love.math.random(#TRAITS)]
            while trait2 == trait1 do
                trait2 = TRAITS[love.math.random(#TRAITS)]
            end
            table.insert(self.traits, trait2)
        end

        -- Trait 3
        if trait_n > 2 then
            trait3 = TRAITS[love.math.random(#TRAITS)]
            while trait3 == trait1 or trait3 == trait2 do
                trait3 = TRAITS[love.math.random(#TRAITS)]
            end
            table.insert(self.traits, trait3)
        end

        self.sx = ROOM_CW/self.body:getWidth()
        self.sy = ROOM_CH/self.body:getHeight()

        -- Get random name from list
        self.name = NAMES[love.math.random(#NAMES)]

        -- Inventory
        self.inv = nil
    end
}

function Bot:kill(grid)
    Object.kill(self, grid)
    Signal.emit("death")
    --SFX.fail:stop()
    --SFX.fail:play()
end

function Bot:next_block(grid, r, c)
    local p = ORIENT[self.r[2]]
    local px, py = self.pos.x + p.x, self.pos.y + p.y
    if  px < 1 or
        px > r or
        py < 1 or
        py > c then
        return nil
    end
    return grid[px][py]
end

function Bot:move(grid, r, c)
    local x, y = self.pos.x, self.pos.y
    Object.move(self, grid, r, c)
    if x ~= self.pos.x or y ~= self.pos.y then
        self.steps = self.steps + 1
    end
end

function Bot:pickup(grid, r, c)
    local p = ORIENT[self.r[2]]
    local px, py = self.pos.x + p.x, self.pos.y + p.y
    local _o = grid[px][py]
    if _o and _o.pickable then
        self.inv = _o
        grid[px][py] = nil
    end
end

function Bot:drop(grid, r, c)
    local p = ORIENT[self.r[2]]
    if self.inv then
        self.inv:use(self, grid, self.pos.x + p.x, self.pos.y + p.y)
    end
end

function Bot:blocked(grid, r, c)
    local p = ORIENT[self.r[2]]
    local px, py = self.pos.x + p.x, self.pos.y + p.y
    if  px < 1 or
        px > r or
        py < 1 or
        py > c then
        return true
    end
    local _o = grid[px][py]
    return _o and (_o.tp ~= "dead" and _o.tp ~= "dead_switch")
end

function Bot:draw()
    Color.set(self.body_clr)
    love.graphics.draw(self.body, self.rx + ROOM_CW/2, self.ry + ROOM_CH/2, self.r[1],
        self.sx, self.sy, ROOM_CW, ROOM_CH)
    Color.set(self.head_clr)
    love.graphics.draw(self.head, self.rx + ROOM_CW/2, self.ry + ROOM_CH/2, self.r[1],
        self.sx, self.sy, ROOM_CW, ROOM_CH)
end

return bot
