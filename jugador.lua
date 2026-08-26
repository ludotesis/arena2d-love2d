--[[
-- Tabla Jugador
jugador = {
    y = 0,
    x = 0,
    alto = 0,
    ancho = 0,
    origen_x = 0,
    origen_y = 0,
    hitbox_x = 0,
    hitbox_y = 0,
    velocidad = 72,
    sprite = nil
}
]]
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

Jugador = Class{}
-- =================== INICIALIZACION ===================
function Jugador:init(x, y)
    self.sprite = love.graphics.newImage("img/Ninja.png")
    self.ancho = self.sprite:getWidth()
    self.alto  = self.sprite:getHeight()
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
    self.x = x
    self.y = y
end
-- =================== ACTUALIZAR ===================
function Actualizar()
    
end
-- =================== RENDERIZADO ===================
function Dibujar()
    
end