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
    love.graphics.setFont(fuente)
    love.graphics.setColor(0, 1, 0)
    love.graphics.printf(self.titulo, 0, 64, ventana.ancho * ventana.escala, 'center')
    love.graphics.setColor(0, 1, 1)
    love.graphics.printf(self.subtitulo, 0, 100, ventana.ancho * ventana.escala, 'center')
end 