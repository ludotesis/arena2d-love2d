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
    alto = 0,
    ancho = 0,
    origen_x = 0,
    origen_y = 0 ,
    velocidad = 72,
    sprite = nil
}
-- Tabla Enemigo
enemigo = {
    y = 100,
    x = 100,
    sprite = nil,
    velocidad = 40,
    origen_x = 0,
    origen_y = 0
}
function love.load()
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    -- Cargar Assets
    jugador.sprite = love.graphics.newImage("img/Ninja.png")
    enemigo.sprite = love.graphics.newImage("img/Samurai.png")
    -- Calcular Alto y Ancho del Sprite Jugador
    jugador.ancho = jugador.sprite:getWidth()
    jugador.alto  = jugador.sprite:getHeight()
    -- Calcular Alto y Ancho del Sprite Enemigo
    enemigo.origen_x = enemigo.sprite:getWidth() / 2
    enemigo.origen_y = enemigo.sprite:getHeight() / 2
    -- Calcular Centro
    jugador.origen_x = jugador.ancho/2
    jugador.origen_y = jugador.alto/2
    -- Centrar Jugador
    jugador.x = ventana.ancho / 2
    jugador.y = ventana.alto / 2
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        jugador.x = jugador.x + (jugador.velocidad * dt)
    elseif love.keyboard.isDown("left") then
        jugador.x = jugador.x - (jugador.velocidad * dt)
    elseif love.keyboard.isDown("down") then
        jugador.y = jugador.y + (jugador.velocidad * dt)
    elseif love.keyboard.isDown("up") then
        jugador.y = jugador.y - (jugador.velocidad * dt)
    end
    -- Persecución
    local dist_x = math.abs(enemigo.x - jugador.x)
    local dist_y = math.abs(enemigo.y - jugador.y)

    if dist_x > dist_y then
        if dist_x > jugador.ancho then
            if enemigo.x < jugador.x then
                enemigo.x = enemigo.x + (enemigo.velocidad * dt)
            elseif enemigo.x > jugador.x then
                enemigo.x = enemigo.x - (enemigo.velocidad * dt)
            end
        end
    else
        if dist_y > jugador.alto then
            if enemigo.y < jugador.y then
                enemigo.y = enemigo.y + (enemigo.velocidad * dt)
            elseif enemigo.y > jugador.y then
                enemigo.y = enemigo.y - (enemigo.velocidad * dt)
            end
        end
    end
end


function redondear(n)
  return math.floor(n + 0.5)
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(jugador.sprite,redondear(jugador.x),redondear(jugador.y),0,1,1, jugador.origen_x, jugador.origen_y)
        love.graphics.draw(enemigo.sprite,redondear(enemigo.x),redondear(enemigo.y),0, 1, 1, enemigo.origen_x, enemigo.origen_y)

        love.graphics.rectangle("line", jugador.x - jugador.origen_x , jugador.y - jugador.origen_y, jugador.ancho, jugador.alto)
        love.graphics.rectangle("line", enemigo.x, enemigo.y, 16, 16)
        --love.graphics.circle("fill", jugador.x, jugador.y, 1)
    love.graphics.setCanvas()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
end