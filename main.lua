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
-- =================== INICIALIZACION ===================
function love.load()
    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)
    love.graphics.setDefaultFilter("nearest", "nearest")
    lienzo  = love.graphics.newCanvas(ventana.ancho, ventana.alto)
    -- estado = EstadoTitulo()
    -- Objeto Global FSM
    MaquinaEstadoGlobal = MaquinaEstado{
        ['titulo']   = function() return EstadoTitulo() end,
        ['jugar']    = function() return EstadoJugar() end,
        ['derrota']    = function() return EstadoDerrota() end
    }

    MaquinaEstadoGlobal:cambiar('titulo')
end
-- =================== INTERACCION ===================
function love.keypressed(key, scancode, isrepeat)
   if key == "f1" then
      depurar = not depurar
   end

   if key == "return" then
        --estado = EstadoJugar()
        MaquinaEstadoGlobal:cambiar('jugar')
   end

   if key == "escape" then
        --estado = EstadoTitulo()
        MaquinaEstadoGlobal:cambiar('titulo')
   end
end

function love.update(dt)
    --estado:actualizar(dt)
    MaquinaEstadoGlobal:actualizar(dt)
end

function love.draw()
    --estado:dibujar()
    MaquinaEstadoGlobal:dibujar(dt)
end