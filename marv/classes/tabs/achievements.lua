--[[
#####################################
Marvellous Inc.
Copyright (C) 2017  MarvellousSoft & USPGameDev
See full license in file LICENSE.txt
(https://github.com/MarvellousSoft/MarvInc/blob/dev/LICENSE.txt)
#####################################
]]--

require "classes.primitive"
local Color = require "classes.color.color"
require "classes.tabs.tab"
require "classes.button"

local ScrollWindow = require "classes.scroll_window"

AchievementsTab = Class {
    __includes = {Tab},

    button_color = 230,

    init = function(self, eps, dy)
        Tab.init(self, eps, dy)

        self.w = self.w - 13 / 2

        self.true_h = 0
        local obj = { -- scroll bar in case some day we have too many options
            pos = self.pos,
            getHeight = function() return self.true_h end,
            draw = function() self:trueDraw() end,
            mousePressed = function(obj, ...) self:trueMousePressed(...) end,
            mouseReleased = function(obj, ...) self:trueMouseReleased(...) end,
            mouseMoved = function(obj, ...) self:trueMouseMoved(...) end,
            mouseScroll = function(obj, ...) self:trueMouseScroll(...) end
        }
        self.box = ScrollWindow(self.w + 5, self.h, obj)
        self.box.sw = 13
        self.box.color = {12, 30, 10}

        self.title_font = FONTS.firaBold(50)
        self.title_gap = 70 --Gap between title and achievements
        self.ach_name_font = FONTS.firaBold(25)
        self.ach_descr_font = FONTS.fira(20)
        self.ach_image_scale = .5 --Scale to apply on achievement image
        self.ach_gap = 30 --Gap between each achievement

        self.text_color = {0, 0, 0}

        self:updateTrueH()

        self.tp = "achievements_tab"
        self:setId("achievements_tab")
    end
}

function AchievementsTab:trueDraw()
    love.graphics.setColor(self.text_color)

    local h = 0
     -- Draw Title
    love.graphics.setFont(self.title_font)
    love.graphics.printf("Achievements", self.pos.x, self.pos.y + self.title_font:getHeight() * .2, self.w, 'center')
    h = h + self.title_font:getHeight() * 2 + self.title_gap

    local x = 50
    local scale = self.ach_image_scale
    --Draw Achievements
    for _, ach in ipairs(ACHIEVEMENT_DATABASE) do
        local image
        if ACHIEVEMENT_PROGRESS[ach[1]] then
            image = ach[4] --completed
        else
            image = ach[3] --incompleted
        end
        --Draw image
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(image, x, h, nil, scale)
        --Draw achievement name
        local name_font = self.ach_name_font
        local descr_font = self.ach_descr_font
        local text_x = x + image:getWidth()*scale + 20
        local small_gap = 3
        local name_y = h + image:getHeight()*scale/2 - (name_font:getHeight(ach[1]) + small_gap + descr_font:getHeight(ach[2]))/2
        love.graphics.setColor(self.text_color)
        love.graphics.setFont(name_font)
        love.graphics.print(ach[1], text_x, name_y)
        --Draw achievement description
        love.graphics.setFont(descr_font)
        love.graphics.print(ach[2], text_x, name_y + name_font:getHeight(ach[1]) + small_gap)

        h = h + image:getHeight()*scale + self.ach_gap
    end

end

function AchievementsTab:updateTrueH()
    local h =  self.title_font:getHeight() * 2 + self.title_gap
    for _, ach in ipairs(ACHIEVEMENT_DATABASE) do
        local image
        if ACHIEVEMENT_PROGRESS[ach[1]] then
            image = ach[4] --completed
        else
            image = ach[3] --incompleted
        end
        h = h + image:getHeight()*self.ach_image_scale + self.ach_gap
    end
    if #ACHIEVEMENT_DATABASE > 0 then
        h = h - self.ach_gap
    end
    self.true_h = h
end

function AchievementsTab:trueMousePressed(x, y, but)
end

function AchievementsTab:trueMouseReleased(x, y, but)
end


function AchievementsTab:trueMouseMoved(...)
end

function AchievementsTab:trueMouseScroll(x, y)
end

-----------------------------

function AchievementsTab:mousePressed(x, y, but)
    self.box:mousePressed(x, y, but)
end

function AchievementsTab:mouseMoved(...)
    self.box:mouseMoved(...)
end

function AchievementsTab:mouseReleased(x, y, but)
    self.box:mouseReleased(x, y, but)
end

function AchievementsTab:update(dt)
    self.box:update(dt)
end

function AchievementsTab:mouseScroll(x, y)
    self.box:mouseScroll(x, y)
end

function AchievementsTab:draw()
    self.box:draw()
end
