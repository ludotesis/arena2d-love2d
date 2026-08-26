-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

Enemigo = Class{}
-- =================== INICIALIZACION ===================
--function Enemigo:Nuevo(x, y,img, v)
function Enemigo:init(x, y,img, v)
    self.x = x
    self.y = y
    self.sprite = love.graphics.newImage(img)
    self.ancho = self.sprite:getWidth()
    self.alto  = self.sprite:getHeight()
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
    self.hitbox_x = 0
    self.hitbox_y = 0
    self.velocidad = v
end
-- =================== ACTUALIZAR ===================
function Enemigo:Actualizar(x,y,a,dt)
    -- Persecución
    local dist_x = math.abs(self.x - x)
    local dist_y = math.abs(self.y - y)

    if dist_x > dist_y then
        if dist_x > a then
            if self.x < x then
                self.x = self.x + (self.velocidad * dt)
            elseif self.x > x then
                self.x = self.x - (self.velocidad * dt)
            end
        end
    else
        if dist_y > a then
            if self.y < y then
                self.y = self.y + (self.velocidad * dt)
            elseif self.y > y then
                self.y = self.y - (self.velocidad * dt)
            end
        end
    end

    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
end
-- =================== RENDERIZADO ===================
function Enemigo:Dibujar()
    love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0, 1, 1, self.origen_x, self.origen_y)
end


-- =================== DEPURAR ===================
function Enemigo:Debug()
    love.graphics.rectangle("line", redondear(self.hitbox_x), redondear(self.hitbox_y), self.ancho, self.alto)
    love.graphics.circle("fill", redondear(self.x), redondear(self.y), 1)
end
