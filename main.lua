-- Resolucion
ANCHO_VENTANA = 160
ALTO_VENTANA  = 144
ESCALA = 4
-- Entidades
jugador = {
    y = 0,
    x = 0,
    sprite = nil
}

enemigo = {
    y = 100,
    x = 100,
    sprite = nil
}

function love.load()
    love.window.setMode(ANCHO_VENTANA * ESCALA, ALTO_VENTANA * ESCALA)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo = love.graphics.newCanvas(ANCHO_VENTANA, ALTO_VENTANA)

    jugador.sprite = love.graphics.newImage("img/Ninja.png")
    enemigo.sprite = love.graphics.newImage("img/Samurai.png")
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(jugador.sprite,jugador.x,jugador.y,0)
        love.graphics.draw(enemigo.sprite,enemigo.x,enemigo.y,0)
    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ESCALA, ESCALA)
end