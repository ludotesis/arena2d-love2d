require 'dependencias'

ventana = {
    ancho  = 160,
    alto   = 144,
    escala = 4
}

depurar  = true

enemigos = {}
atrapado = false

mapa = nil
camara_principal = nil
mundo = nil

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
    -- cargar mapa
    mapa = STI('mapa/arena1.lua')
    -- Mundo AABB
    mundo = Bump.newWorld(16)
    -- Generar Paredes
    if mapa.layers["Paredes"] then
        for _, obj in ipairs(mapa.layers["Paredes"].objects) do
            obj.es_pared = true
            mundo:add(obj, obj.x, obj.y, obj.width, obj.height)
        end
    end
    -- Instancias    
    jugador = Jugador(ventana.ancho / 2,ventana.alto / 2, 72, mundo)
    table.insert(enemigos, Samurai(80, 100, "img/Samurai.png", 10, mundo))
    table.insert(enemigos, Enemigo(130, 72, "img/Esqueleto.png", 4, mundo))
    table.insert(enemigos, Caballero(30, 72, "img/Caballero.png", 6, mundo))
    table.insert(enemigos, Caballero(60, 10, "img/Caballero.png", 8, mundo))
    table.insert(enemigos, Enemigo(100, 10, "img/Esqueleto.png", 6, mundo))
    -- crear camara
    camara_principal = Camara()
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   end
end

function love.update(dt)
    atrapado = false

    jugador:Actualizar(dt)
    --camara_principal:lookAt(jugador.x, jugador.y)
    camara_principal:lookAt(redondear(jugador.x), redondear(jugador.y))
    for i, enemigo in ipairs(enemigos) do
         enemigo:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)
        --[[
        if jugador:Colision(
            enemigo.hitbox_x,
            enemigo.hitbox_y,
            enemigo.ancho,
            enemigo.alto
        )then
            
        end
        ]]
    end
    atrapado = jugador:Colision()
    --- limites de camara_principal
    if camara_principal.x < ventana.ancho * 0.5 then
        camara_principal.x = ventana.ancho * 0.5
    end

    if camara_principal.y < ventana.alto * 0.5 then
        camara_principal.y = ventana.alto * 0.5
    end

    local mapa_ancho = mapa.width * mapa.tilewidth
    local mapa_alto  = mapa.height * mapa.tileheight

    if camara_principal.x > (mapa_ancho - ventana.ancho * 0.5) then
        camara_principal.x = (mapa_ancho - ventana.ancho * 0.5)
    end

    if camara_principal.y > (mapa_alto - ventana.alto * 0.5) then
        camara_principal.y = (mapa_alto - ventana.alto * 0.5)
    end
end

function love.draw()
  love.graphics.setCanvas(lienzo)
    love.graphics.clear()

    camara_principal:attach(0, 0, ventana.ancho, ventana.alto)
        
        --mapa:draw()
        if mapa.layers["Piso"] then
            mapa:drawLayer(mapa.layers["Piso"])
        end

        jugador:Dibujar()

        if mapa.layers["Deco"] then
            mapa:drawLayer(mapa.layers["Deco"])
        end

        for i, enemigo in ipairs(enemigos) do
            enemigo:Dibujar()
        end

        if depurar then
            --debugHitboxes()
            local items = mundo:getItems()
            for _, item in ipairs(items) do
                local x, y, ancho, alto = mundo:getRect(item)
                love.graphics.rectangle("line", redondear(x), redondear(y), ancho, alto)
            end
        end

    camara_principal:detach()
    love.graphics.setCanvas()
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

    
    if depurar then
        debugUI()
    end
end