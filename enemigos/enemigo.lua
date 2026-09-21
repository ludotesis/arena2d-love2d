Enemigo = Class{}
-- =================== INICIALIZACION ===================
--function Enemigo:Nuevo(x, y,img, v)
function Enemigo:init(x, y,img, v, mundo)
    self.x = x
    self.y = y
    self.sprite = love.graphics.newImage(img)
    self.ancho = self.sprite:getWidth()
    self.alto  = self.sprite:getHeight()
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
    --self.hitbox_x = 0
    --self.hitbox_y = 0
    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
    self.velocidad = v

    self.color = {1, 1, 1, 1}
    self.detenido = false

    self.mundo = mundo
    self.es_enemigo = true
    self.mundo:add(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)

    --love.handlers.deneterEnemigos = function() self:Detener() end
    Eventos.on("deneterEnemigos", function() self:Detener() end)
end
-- =================== ACTUALIZAR ===================
function Enemigo:Actualizar(x,y,a,dt)

    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
    self.mundo:update(self, self.hitbox_x, self.hitbox_y, self.ancho, self.alto)
end
-- =================== RENDERIZADO ===================
function Enemigo:Dibujar()
    love.graphics.setColor(self.color)
        love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0, 1, 1, self.origen_x, self.origen_y)
    love.graphics.setColor(1,1,1)
end
-- =================== DEPURAR ===================
function Enemigo:Debug()
    love.graphics.rectangle("line", redondear(self.hitbox_x), redondear(self.hitbox_y), self.ancho, self.alto)
    love.graphics.circle("fill", redondear(self.x), redondear(self.y), 1)
end

function Enemigo:Detener()
    self.detenido = true
    self.color = {0, 0, 1, 0.5}
end