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
function enemigo.Crear()
    enemigo.sprite = love.graphics.newImage("img/Caballero.png")
    enemigo.ancho = enemigo.sprite:getWidth()
    enemigo.alto  = enemigo.sprite:getHeight()
    enemigo.origen_x = enemigo.ancho/2
    enemigo.origen_y = enemigo.alto/2
end
-- =================== ACTUALIZAR ===================
function Actualizar()
    
end
-- =================== RENDERIZADO ===================
function Dibujar()
    
end