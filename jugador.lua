-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib.class'

Jugador = Class{}
-- =================== INICIALIZACION ===================
function Jugador:init(x, y, v, mundo)
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
    self.anterior_x = self.x
    self.anterior_y = self.y

    self.mundo = mundo
    self.mundo:add(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
end
-- =================== ACTUALIZAR ===================
function Jugador:Actualizar(dt)

    self.anterior_x = self.x
    self.anterior_y = self.y

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
    self.mundo:update(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
end
-- =================== Colision ===================
function Jugador:Colision()
    --[[
   return  self.hitbox_x < otro_hitbox_x + otro_ancho and
           otro_hitbox_x < self.hitbox_x + self.ancho and
           self.hitbox_y < otro_hitbox_y + otro_alto and
           otro_hitbox_y < self.hitbox_y + self.alto
    ]]
    local hitboxes, cantidad = self.mundo:queryRect(self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
    
    for i = 1, cantidad do
        local objeto = hitboxes[i]

        if objeto ~= self then
            if objeto.es_enemigo then
                return true
            elseif objeto.es_pared then
                self.x = self.anterior_x
                self.y = self.anterior_y
                self.hitbox_x = self.x - self.origen_x
                self.hitbox_y = self.y - self.origen_y
                self.mundo:update(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
            end
        end
    end
    return false
end
-- =================== RENDERIZADO ===================
function Jugador:Dibujar()
    love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0,1,1, self.origen_x, self.origen_y)
end