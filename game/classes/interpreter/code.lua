local Ops = require "classes.interpreter.operations"
local Color = require "classes.color.color"

Code = Class{
    init = function(self, ops, labs)
        self.ops = ops
        self.labs = labs
        self.cur = 1
    end,
    type = 'code'
}

function Code:start()
    local ct = Util.findId("code_tab")
    ct:showLine(1)
    ct.lock = true
    ct.memory:reset()
end

function Code:step()
    Util.findId("code_tab"):showLine(self.cur)
    if self.cur <= #self.ops then
        local lab = self.ops[self.cur]:execute()
        if lab then
            self.cur = self.labs[lab]
            if not self.cur then
                ROOM.fail_title = "Code Error!"
                ROOM.fail_text = "Your code got a runtime error (0x" .. love.math.random(10000, 99999) .. ")\n\nError message: \"" .. lab .. "\"\n\n For this reason, subject #" .. Util.findId("info_tab").dead .. " \"" .. ROOM.bot.name .. "\" is no longer working and will be sacrificed and replaced."
                ROOM.fail_button = "I'm sorry."
                StepManager:stop()
                return false
            end
        else
            self.cur = self.cur + 1
        end
    end
    return self.cur <= #self.ops
end

function Code:stop()
    local ct = Util.findId("code_tab")
    ct:showLine(nil)
    ct.lock = false
end
