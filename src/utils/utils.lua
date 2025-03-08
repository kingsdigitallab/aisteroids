local Utils = {}

-- Convert rotation to angle (adjusting for Love2D's coordinate system)
function Utils.get_angle(rotation)
    return rotation - math.pi / 2
end

-- Check collision between two circles
function Utils.circle_collision(x1, y1, r1, x2, y2, r2)
    local dx = x2 - x1
    local dy = y2 - y1
    local dist = math.sqrt(dx * dx + dy * dy)
    return dist < (r1 + r2)
end

-- Get distance between two points
function Utils.get_distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

return Utils
