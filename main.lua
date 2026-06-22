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
    origen_y = 0,
    hitbox_x = 0,
    hitbox_y = 0,
    velocidad = 72,
    sprite = nil,
    spritesheet = nil,
    correr = {
        quads = {},
        indice = 1,
        activado = true
    }
}
-- Tabla Enemigo
enemigo = {
    y = 100,
    x = 100,
    alto = 0,
    ancho = 0,
    origen_x = 0,
    origen_y = 0,
    hitbox_x = 0,
    hitbox_y = 0,
    velocidad = 40,
    sprite = nil
}
atrapado = false
depurar  = false
-- Ataque
ataque = {
    spritesheet = nil,
    quads = {},
    indice = 1,
    activado = false
}
-- Aura
aura = {
    spritesheet = nil,
    quads = {},
    indice = 1,
    activado = true
}
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
    -- Cargar Assets
    jugador.sprite = love.graphics.newImage("img/Ninja.png")
    enemigo.sprite = love.graphics.newImage("img/Samurai.png")
    ataque.spritesheet = love.graphics.newImage("img/CortarSprites.png")
    aura.spritesheet = love.graphics.newImage("img/AuraSprites.png")
    jugador.spritesheet = love.graphics.newImage("img/NinjaSprites.png")
    for i = 0, 3 do
        table.insert(ataque.quads, love.graphics.newQuad(32 * i ,0,32,32, ataque.spritesheet))
    end
    for i = 0, 4 do
        table.insert(aura.quads, love.graphics.newQuad(25 * i ,0,25,24, aura.spritesheet))
    end
    for i = 0, 3 do
        table.insert(jugador.correr.quads, love.graphics.newQuad(0,16* i,16,16, jugador.spritesheet))
    end
    -- Calcular Altos y Anchos 
    jugador.ancho = jugador.sprite:getWidth()
    jugador.alto  = jugador.sprite:getHeight()
    enemigo.ancho = enemigo.sprite:getWidth()
    enemigo.alto  = enemigo.sprite:getHeight()
    -- Calcular Centros
    jugador.origen_x = jugador.ancho/2
    jugador.origen_y = jugador.alto/2
    enemigo.origen_x = enemigo.ancho/2
    enemigo.origen_y = enemigo.alto/2
    -- Centrar Jugador
    jugador.x = ventana.ancho / 2
    jugador.y = ventana.alto / 2
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   elseif key == "space" and not ataque.activado then
      ataque.activado = true
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
    -- Actualizar Ataque
    if ataque.activado then
        ataque.indice = ataque.indice + (12 * dt)
        if ataque.indice >= #ataque.quads + 1 then
            ataque.indice = 1
            ataque.activado = false
        end
    end
    -- Actualizar Aura
    if aura.activado then
        aura.indice = aura.indice + (12 * dt)
        if aura.indice >= #aura.quads + 1 then
            aura.indice = 1
        end
    end
    -- Actualizar Correr
    if jugador.correr.activado then
        jugador.correr.indice = jugador.correr.indice + (10 * dt)
        if jugador.correr.indice >= #jugador.correr.quads + 1 then
            jugador.correr.indice = 1
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
    -- Activacion de Aura
    if atrapado then
        aura.activado = false
    else
        aura.activado = true
    end
end

function love.draw()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        love.graphics.draw(enemigo.sprite,redondear(enemigo.x),redondear(enemigo.y),0, 1, 1, enemigo.origen_x, enemigo.origen_y)
        if jugador.correr.activado then
            local i = math.floor(jugador.correr.indice)
            love.graphics.draw(jugador.spritesheet, jugador.correr.quads[i],redondear(jugador.x),redondear(jugador.y),0,1,1, jugador.origen_x, jugador.origen_y)    
        end
        if ataque.activado then
            local i = math.floor(ataque.indice)
            love.graphics.draw(ataque.spritesheet,ataque.quads[i], jugador.x, jugador.y,0,1,1, jugador.origen_x + 8, jugador.origen_y + 8)
        end
        if aura.activado then
            local i = math.floor(aura.indice)
            love.graphics.draw(aura.spritesheet,aura.quads[i], enemigo.x, enemigo.y, 0, 1, 1, enemigo.origen_x + 4  , enemigo.origen_y + 4 )
        end
        if depurar then
            debugHitboxes()
        end
    love.graphics.setCanvas()
    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
    if depurar then
        debugUI()
    end
end