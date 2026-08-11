require "jugador"
require "enemigo"

-- Tabla Ventana
ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}

atrapado = false
depurar  = true
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
    love.graphics.circle("fill", redondear(jugador.x), redondear(jugador.y), 1)
    enemigo1:Debug()
    enemigo2:Debug()
    enemigo3:Debug()
    love.graphics.setColor(1, 1, 1)
end
-- =================== INICIALIZACION ===================
function love.load()
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    jugador.Crear(ventana.ancho / 2,ventana.alto / 2)

    enemigo1 = Enemigo:Nuevo(80, 100, "img/Samurai.png", 4)
    enemigo2 = Enemigo:Nuevo(130, 72, "img/Esqueleto.png", 8)
    enemigo3 = Enemigo:Nuevo(30, 72, "img/Caballero.png", 12)
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

    --Enemigo:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
    enemigo1:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
    enemigo2:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
    enemigo3:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)

    -- Calcular Hitboxes
    jugador.hitbox_x = jugador.x - jugador.origen_x
    jugador.hitbox_y = jugador.y - jugador.origen_y
 
    -- Verificar Colision AABB
    atrapado = comprobarColision(
        jugador.hitbox_x,
        jugador.hitbox_y,
        jugador.ancho,
        jugador.alto,
        enemigo1.hitbox_x,
        enemigo1.hitbox_y,
        enemigo1.ancho,
        enemigo1.alto
    )
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(jugador.sprite,redondear(jugador.x),redondear(jugador.y),0,1,1, jugador.origen_x, jugador.origen_y)
        enemigo1:Dibujar()
        enemigo2:Dibujar()
        enemigo3:Dibujar()
        if depurar then
            debugHitboxes()
        end
    love.graphics.setCanvas()
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
    if depurar then
        debugUI()
    end
end