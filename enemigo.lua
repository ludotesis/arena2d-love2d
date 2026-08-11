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
    self.ancho = self.sprite:getWidth()
    self.alto  = self.sprite:getHeight()
    self.origen_x = self.ancho/2
    self.origen_y = self.alto/2
end
-- =================== ACTUALIZAR ===================
function  enemigo.Actualizar(self,x,y,a,dt)
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
function enemigo.Dibujar(self)
    love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0, 1, 1, self.origen_x, self.origen_y)
end


enemigo2 = {
    y = 100,
    x = 0,
    alto = 0,
    ancho = 0,
    origen_x = 0,
    origen_y = 0,
    hitbox_x = 0,
    hitbox_y = 0,
    velocidad = 40,
    sprite = nil,
    crear = enemigo.Crear,
    actualizar = enemigo.Actualizar,
    dibujar = enemigo.Dibujar
}