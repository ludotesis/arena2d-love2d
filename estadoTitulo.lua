EstadoTitulo = Class { __includes = Estado }

function EstadoTitulo:init()
    self.titulo = ""
    self.subtitulo = ""
end
function EstadoTitulo:ingresar(datos)
    self.titulo = datos.titulo
    self.subtitulo = datos.subtitulo
end
function EstadoTitulo:salir() end
function EstadoTitulo:actualizar(dt) end

function EstadoTitulo:dibujar()
    love.graphics.printf(self.titulo, 0, 64, ventana.ancho, 'center')
    love.graphics.printf(self.subtitulo, 0, 100, ventana.ancho, 'center')
end