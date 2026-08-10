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
-- =================== INICIALIZACION ===================
function jugador.Crear(x, y)
    jugador.sprite = love.graphics.newImage("img/Ninja.png")
    jugador.ancho = jugador.sprite:getWidth()
    jugador.alto  = jugador.sprite:getHeight()
    jugador.origen_x = jugador.ancho/2
    jugador.origen_y = jugador.alto/2
    jugador.x = x
    jugador.y = y
end
-- =================== ACTUALIZAR ===================
function Actualizar()
    
end
-- =================== RENDERIZADO ===================
function Dibujar()
    
end