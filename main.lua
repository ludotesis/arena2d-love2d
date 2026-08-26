require 'dependencias'

ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}

depurar  = true

enemigos = {}
atrapado = false

estado = nil

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

    for i, enemigo in ipairs(enemigos) do
        enemigo:Debug()
    end
    love.graphics.setColor(1, 1, 1)
end
-- =================== INICIALIZACION ===================
function love.load()
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo  = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    -- Instancias  
    --[[
    jugador = Jugador(ventana.ancho / 2,ventana.alto / 2, 72)
    table.insert(enemigos, Samurai(80, 100, "img/Samurai.png", 10))
    table.insert(enemigos, Enemigo(130, 72, "img/Esqueleto.png", 4))
    table.insert(enemigos, Caballero(30, 72, "img/Caballero.png", 6))
    table.insert(enemigos, Caballero(60, 10, "img/Caballero.png", 8))
    table.insert(enemigos, Enemigo(100, 10, "img/Esqueleto.png", 6))
    ]]
    estado = EstadoJugar()
    --estado = EstadoTitulo()
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   end
end

function love.update(dt)
    --[[
    atrapado = false

    jugador:Actualizar(dt)

    for i, enemigo in ipairs(enemigos) do
 
        enemigo:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)

        if jugador:Colision(
            enemigo.hitbox_x,
            enemigo.hitbox_y,
            enemigo.ancho,
            enemigo.alto
        )then
            atrapado = true
        end
    end
    ]]
    estado:actualizar(dt)
end

function love.draw()
    --[[
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        jugador:Dibujar()
        for i, enemigo in ipairs(enemigos) do
            enemigo:Dibujar()
        end

        if depurar then
            debugHitboxes()
        end
    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
    if depurar then
        debugUI()
    end
    ]]
    estado:dibujar()
end