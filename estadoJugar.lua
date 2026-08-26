EstadoJugar = Class { __includes = Estado }

function EstadoJugar:init()
    jugador = Jugador(ventana.ancho / 2,ventana.alto / 2, 72)
    table.insert(enemigos, Samurai(80, 100, "img/Samurai.png", 10))
    table.insert(enemigos, Enemigo(130, 72, "img/Esqueleto.png", 4))
    table.insert(enemigos, Caballero(30, 72, "img/Caballero.png", 6))
    table.insert(enemigos, Caballero(60, 10, "img/Caballero.png", 8))
    table.insert(enemigos, Enemigo(100, 10, "img/Esqueleto.png", 6))
end
function EstadoJugar:ingresar() end
function EstadoJugar:salir() end
function EstadoJugar:actualizar(dt)
    atrapado = false

    jugador:Actualizar(dt)

    for i, enemigo in ipairs(enemigos) do
 
        enemigo:Actualizar(jugador.x, jugador.y, jugador.ancho, dt)

        if jugador:Colision(
            enemigo.hitbox_x,
            enemigo.hitbox_y,
            enemigo.ancho,
            enemigo.alto
        )then
            atrapado = true
        end
    end
end
function EstadoJugar:dibujar()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        jugador:Dibujar()
        for i, enemigo in ipairs(enemigos) do
            enemigo:Dibujar()
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