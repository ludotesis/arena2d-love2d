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
-- =================== ACTUALIZACION ===================
function ActualizarAnimacion(animacion,dt, unaVez)
    if animacion.activado then
        animacion.indice = animacion.indice + (animacion.velocidad * dt)
        if animacion.indice >= #animacion.quads + 1 then
            animacion.indice = 1
            if unaVez then
                animacion.activado = false
            end
        end
    end
end