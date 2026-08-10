-- Tabla Enemigo
enemigo = {
    y = 100,
    x = 100,
    alto = 0,
    ancho = 0,
    origen_x = 0,
    origen_y = 0,
    hitbox_x = 0,
    hitbox_y = 0,
    velocidad = 40,
    sprite = nil
}
-- =================== INICIALIZACION ===================
function enemigo.Crear(self, img)
    self.sprite = love.graphics.newImage(img)
    self.ancho = enemigo.sprite:getWidth()
    self.alto  = enemigo.sprite:getHeight()
    self.origen_x = enemigo.ancho/2
    self.origen_y = enemigo.alto/2
end
-- =================== ACTUALIZAR ===================
function Actualizar()
    
end
-- =================== RENDERIZADO ===================
function enemigo.Dibujar(self)
    love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0, 1, 1, self.origen_x, self.origen_y)
end