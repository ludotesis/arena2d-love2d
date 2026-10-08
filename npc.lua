NPC = Class{}
-- =================== INICIALIZACION ===================
function NPC:init(x, y,img, v, mundo)
    self.x = x
    self.y = y
    self.sprite = love.graphics.newImage(img)
    self.ancho = self.sprite:getWidth()
    self.alto  = self.sprite:getHeight()
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
    self.velocidad = v

    self.color = {1, 1, 1, 1}
    self.detenido = false

    self.mundo = mundo
    self.es_npc = true
    self.mundo:add(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
end
-- =================== ACTUALIZAR ===================
function NPC:Actualizar(x,y,a,dt)
    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
    self.mundo:update(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
end
-- =================== RENDERIZADO ===================
function NPC:Dibujar()
    love.graphics.setColor(self.color)
        love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0, 1, 1, self.origen_x, self.origen_y)
    love.graphics.setColor(1,1,1)
end
-- =================== DEPURAR ===================
function NPC:Debug()
    love.graphics.rectangle("line", redondear(self.hitbox_x), redondear(self.hitbox_y), self.ancho, self.alto)
    love.graphics.circle("fill", redondear(self.x), redondear(self.y), 1)
end

