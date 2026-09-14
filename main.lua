require 'dependencias'

ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}

depurar  = true

enemigos = {}
atrapado = false

proyectiles = {}
tiempo_spawn = 0
intervalo_spawn = 0.5

oleada_actual = 0

function generarProyectil()
    local x = math.random(ventana.ancho * 0.25, ventana.ancho * 0.5)
    local y = math.random(ventana.alto  * 0.25, ventana.alto  * 0.5)
    local angulo = math.random() * math.pi * 2
    local velocidad = math.random(30, 70)
    local nuevo_proyectil = Proyectil(x, y, angulo, velocidad)
    table.insert(proyectiles, nuevo_proyectil)
end

function generarOleada(nivel)

    local cantidad = 2 + (nivel * 2)
    local patron = nivel % 3

    local centro_x = ventana.ancho / 2
    local centro_y = ventana.alto / 2

    if patron == 1 then
        local radio = 60
        for i = 1, cantidad do
            local angulo = (i / cantidad) * (math.pi * 2)
            local ex = centro_x + math.cos(angulo) * radio
            local ey = centro_y + math.sin(angulo) * radio
            table.insert(enemigos, Enemigo(ex, ey, "img/Esqueleto.png", 4 + nivel))
        end
    elseif patron == 2 then
        for i = 1, cantidad do
            local fraccion = i / (cantidad + 1)
            local ex = ventana.ancho * fraccion
            local ey = (i % 2 == 0) and -10 or (ventana.alto + 10)
            table.insert(enemigos, Caballero(ex, ey, "img/Caballero.png", 5 + nivel))
        end
    else
        for i = 1, cantidad do
            local progreso = i / cantidad
            local ex = progreso * ventana.ancho
            local ey = (i % 2 == 0) and (progreso * ventana.alto) or (ventana.alto - (progreso * ventana.alto))
            table.insert(enemigos, Samurai(ex, ey, "img/Samurai.png", 6 + nivel))
        end
    end
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
    jugador = Jugador(ventana.ancho / 2,ventana.alto / 2, 72)
    --[[
    table.insert(enemigos, Samurai(80, 100, "img/Samurai.png", 10))
    table.insert(enemigos, Enemigo(130, 72, "img/Esqueleto.png", 4))
    table.insert(enemigos, Caballero(30, 72, "img/Caballero.png", 6))
    table.insert(enemigos, Caballero(60, 10, "img/Caballero.png", 8))
    table.insert(enemigos, Enemigo(100, 10, "img/Esqueleto.png", 6))
    ]]
    -- Seed
    math.randomseed(os.time())
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   end
end

function love.update(dt)
 
    if #enemigos == 0 then
        oleada_actual = oleada_actual + 1
        generarOleada(oleada_actual)
    end

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

    tiempo_spawn = tiempo_spawn + dt
    if tiempo_spawn >= intervalo_spawn then
        generarProyectil()
        tiempo_spawn = 0 
    end

    for i = #proyectiles, 1, -1 do
        local p = proyectiles[i]
        p:Actualizar(dt)
        if p.x < 0 or p.x > ventana.ancho or p.y < 0 or p.y > ventana.alto then
            table.remove(proyectiles, i)
        end
    end
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        jugador:Dibujar()
        for i, enemigo in ipairs(enemigos) do
            enemigo:Dibujar()
        end

        for i, p in ipairs(proyectiles) do
            p:Dibujar()
        end

        if depurar then
            debugHitboxes()
        end
    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
    if depurar then
        debugUI()
    end
    love.graphics.print("Proyectiles activos: " .. #proyectiles, 10, ventana.ancho)
end