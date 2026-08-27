EstadoTitulo = Class { __includes = Estado }

function EstadoTitulo:init()
    self.titulo = "NUEVA ARENA"
end
function EstadoTitulo:ingresar()
    self.titulo = "LUDOTESIS"
end
function EstadoTitulo:salir() end
function EstadoTitulo:actualizar(dt) end

function EstadoTitulo:dibujar()
    love.graphics.printf(self.titulo, 0, 64, ventana.ancho, 'center')
    love.graphics.printf('Presionar Enter', 0, 100, ventana.ancho, 'center')
end