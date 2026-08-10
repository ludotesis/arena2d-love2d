require "jugador"
require "enemigo"

-- Tabla Ventana
ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}


atrapado = false
depurar  = false
-- ================= FUNCIONES ==========================
function comprobarColision(x1, y1, ancho1, alto1, x2, y2, ancho2, alto2)
    return x1 < x2 + ancho2 and
           x2 < x1 + ancho1 and
           y1 < y2 + alto2 and
           y2 < y1 + alto1
end

function redondear(n)
  return math.floor(n + 0.5)
end

function debugUI()
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    if atrapado then
        love.graphics.print("ATRAPADO", 100, 10)
    end
    love.graphics.setColor(1, 1, 1)
end

function debugHitboxes()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("line", redondear(jugador.hitbox_x) , redondear(jugador.hitbox_y), jugador.ancho, jugador.alto)
    love.graphics.rectangle("line", redondear(enemigo.hitbox_x), redondear(enemigo.hitbox_y), enemigo.ancho, enemigo.alto)
    love.graphics.circle("fill", redondear(jugador.x), redondear(jugador.y), 1)
    love.graphics.circle("fill", redondear(enemigo.x), redondear(enemigo.y), 1)
    love.graphics.setColor(1, 1, 1)
end
-- =================== INICIALIZACION ===================
function love.load()
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    jugador.Crear(ventana.ancho / 2,ventana.alto / 2)
    local segundoEnemigo = enemigo
    segundoEnemigo.Crear(segundoEnemigo, "img/Esqueleto.png")
   
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   end
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
    -- Calcular Hitboxes
    jugador.hitbox_x = jugador.x - jugador.origen_x
    jugador.hitbox_y = jugador.y - jugador.origen_y
    enemigo.hitbox_x = enemigo.x - enemigo.origen_x
    enemigo.hitbox_y = enemigo.y - enemigo.origen_y
    -- Verificar Colision AABB
    atrapado = comprobarColision(
        jugador.hitbox_x,
        jugador.hitbox_y,
        jugador.ancho,
        jugador.alto,
        enemigo.hitbox_x,
        enemigo.hitbox_y,
        enemigo.ancho,
        enemigo.alto
    )
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(jugador.sprite,redondear(jugador.x),redondear(jugador.y),0,1,1, jugador.origen_x, jugador.origen_y)
        love.graphics.draw(enemigo.sprite,redondear(enemigo.x),redondear(enemigo.y),0, 1, 1, enemigo.origen_x, enemigo.origen_y)
        if depurar then
            debugHitboxes()
        end
    love.graphics.setCanvas()
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
    if depurar then
        debugUI()
    end
end