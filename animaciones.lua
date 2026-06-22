-- =================== LIBRERIA ANIMACIONES CON QUADS ===================
-- =================== INICIALIZACION ===================
function CrearAnimacion(imagen, limite, ancho, alto, velocidad, esVertical)
    local animacion = {}

    animacion.spritesheet = love.graphics.newImage(imagen)
    animacion.indice = 1
    animacion.velocidad = velocidad
    animacion.quads = {}
    animacion.activado = true
    if esVertical then
        for i = 0, limite, 1 do
            table.insert(animacion.quads, love.graphics.newQuad(0, alto * i, ancho, alto, animacion.spritesheet))
        end
    else
        for i = 0, limite, 1 do
            table.insert(animacion.quads, love.graphics.newQuad(ancho * i, 0, ancho, alto, animacion.spritesheet))
        end
    end

    return animacion
end