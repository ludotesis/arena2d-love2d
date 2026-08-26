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
function Jugador:init(x, y, v)
    self.sprite = love.graphics.newImage("img/Ninja.png")
    self.ancho = self.sprite:getWidth()
    self.alto  = self.sprite:getHeight()
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
    self.x = x
    self.y = y
    self.hitbox_x =  self.x - self.origen_x
    self.hitbox_y =  self.y - self.origen_y
    self.velocidad = v
end
-- =================== ACTUALIZAR ===================
function Jugador:Actualizar(dt)

    if love.keyboard.isDown("right") then
        self.x = self.x + (self.velocidad * dt)
    elseif love.keyboard.isDown("left") then
        self.x = self.x - (self.velocidad * dt)
    elseif love.keyboard.isDown("down") then
        self.y = self.y + (self.velocidad * dt)
    elseif love.keyboard.isDown("up") then
        self.y = self.y - (self.velocidad * dt)
    end

    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
end
-- =================== RENDERIZADO ===================
function Dibujar()
    
end