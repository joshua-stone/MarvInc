local Mail = require "classes.tabs.email"

local pickup = {}

-- Adds the puzzle that teaches pickup/drop

pickup.require_puzzles = {'tuto4'}
pickup.wait = 4

function pickup.run()
    Mail.new('tuto5')
end

return pickup