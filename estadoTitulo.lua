EstadoTitulo = Class { __includes = Estado }

function EstadoTitulo:init() end
function EstadoTitulo:ingresar() end
function EstadoTitulo:salir() end
function EstadoTitulo:actualizar(dt) end

function EstadoTitulo:dibujar()
    love.graphics.printf('ARENA 2D', 0, 64, ventana.ancho, 'center')
    love.graphics.printf('Presionar Enter', 0, 100, ventana.ancho, 'center')
end