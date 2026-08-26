require "jugador"
require "enemigo"

-- Tabla Ventana
ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}


depurar  = true

atrapado1 = false
atrapado2 = false
atrapado3 = false


function redondear(n)
  return math.floor(n + 0.5)
end

function debugUI()
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    if atrapado1 or atrapado2 or atrapado3 then
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
    lienzo  = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    -- Instancias    
    jugador = Jugador(ventana.ancho / 2,ventana.alto / 2, 72)
    ninjaClone = Jugador(ventana.ancho / 2,ventana.alto / 2, 72)
    enemigo1 = Enemigo(80, 100, "img/Samurai.png", 0)
    enemigo2 = Enemigo(130, 72, "img/Esqueleto.png", 0)
    enemigo3 = Enemigo(30, 72, "img/Caballero.png", 0)
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   end
end

function love.update(dt)
    --Enemigo:Actualizar
    enemigo1:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
    enemigo2:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
    enemigo3:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
    -- Jugador Actualizar
    jugador:Actualizar(dt)
     -- Verificar Colision AABB
    atrapado1 = jugador:Colision(
        enemigo1.hitbox_x,
        enemigo1.hitbox_y,
        enemigo1.ancho,
        enemigo1.alto
    )

    atrapado2 = jugador:Colision(
        enemigo2.hitbox_x,
        enemigo2.hitbox_y,
        enemigo2.ancho,
        enemigo2.alto
    )

    atrapado3 = jugador:Colision(
        enemigo3.hitbox_x,
        enemigo3.hitbox_y,
        enemigo3.ancho,
        enemigo3.alto
    )
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        jugador:Dibujar()
        ninjaClone:Dibujar()
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