-- Resolucion
ANCHO_VENTANA = 160
ALTO_VENTANA  = 144
ESCALA = 4

y = 0
x = 0
img = love.graphics.newImage("img/Ninja.png")

function love.load()
    love.window.setMode(ANCHO_VENTANA * ESCALA, ALTO_VENTANA * ESCALA)
    love.graphics.setDefaultFilter("nearest", "nearest")
end

function love.draw()
    love.graphics.draw(img,x,y,0, ESCALA,ESCALA)
end