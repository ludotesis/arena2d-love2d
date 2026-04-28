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
    -- Centrar Jugador
    jugador.x = ventana.alto / 2
    jugador.y = ventana.ancho / 2
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(jugador.sprite,jugador.x,jugador.y,0)
        love.graphics.draw(enemigo.sprite,enemigo.x,enemigo.y,0)
        love.graphics.circle("fill", jugador.x, jugador.y, 1)
    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
end