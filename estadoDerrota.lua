EstadoDerrota = Class { __includes = Estado }

function EstadoDerrota:init() end
function EstadoDerrota:ingresar() end
function EstadoDerrota:salir() end
function EstadoDerrota:actualizar(dt) end

function EstadoDerrota:dibujar()
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf('GAME OVER', 0, 64, ventana.ancho * ventana.escala, 'center')
    love.graphics.printf('Reiniciar', 0, 100, ventana.ancho * ventana.escala, 'center')
end