-- Tabla Ventana
ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}
-- Tabla Jugador
jugador = {
    y = 0,
    x = 0,
    alto,
    ancho,
    origen_x,
    origen_y,
    velocidad = 50,
    sprite = nil
}
-- Tabla Enemigo
enemigo = {
    y = 100,
    x = 100,
    sprite = nil
}
function love.load()
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    -- Cargar Assets
    jugador.sprite = love.graphics.newImage("img/Ninja.png")
    enemigo.sprite = love.graphics.newImage("img/Samurai.png")
    -- Calcular Alto y Ancho del Sprite
    jugador.ancho = jugador.sprite:getWidth()
    jugador.alto  = jugador.sprite:getHeight()
    -- Calcular Centro
    jugador.origen_x = jugador.ancho/2
    jugador.origen_y = jugador.alto/2
    -- Centrar Jugador
    jugador.x = ventana.alto / 2
    jugador.y = ventana.ancho / 2
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        jugador.x = jugador.x + (jugador.velocidad * dt)
    end
    if love.keyboard.isDown("left") then
        jugador.x = jugador.x - (jugador.velocidad * dt)
    end
    if love.keyboard.isDown("down") then
        jugador.y = jugador.y + (jugador.velocidad * dt)
    end
    if love.keyboard.isDown("up") then
        jugador.y = jugador.y - (jugador.velocidad * dt)
    end
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(jugador.sprite,jugador.x,jugador.y,0,1,1, jugador.origen_x, jugador.origen_y)
        love.graphics.draw(enemigo.sprite,enemigo.x,enemigo.y,0)
        love.graphics.circle("fill", jugador.x, jugador.y, 1)
    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
end