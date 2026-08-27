EstadoJugar = Class { __includes = Estado }

function EstadoJugar:init()
    self.enemigos = {}
    self.jugador = Jugador(ventana.ancho / 2,ventana.alto / 2, 72)

    table.insert(self.enemigos, Samurai(80, 100, "img/Samurai.png", 10))
    table.insert(self.enemigos, Enemigo(130, 72, "img/Esqueleto.png", 4))
    table.insert(self.enemigos, Caballero(30, 72, "img/Caballero.png", 6))
    table.insert(self.enemigos, Caballero(60, 10, "img/Caballero.png", 8))
    table.insert(self.enemigos, Enemigo(100, 10, "img/Esqueleto.png", 6))
end
function EstadoJugar:ingresar() end
function EstadoJugar:salir() end
function EstadoJugar:actualizar(dt)
    
    atrapado = false

    self.jugador:Actualizar(dt)

    for i, enemigo in ipairs(self.enemigos) do

        enemigo:Actualizar(self.jugador.x, self.jugador.y, self.jugador.ancho, dt)

        if self.jugador:Colision(
            enemigo.hitbox_x,
            enemigo.hitbox_y,
            enemigo.ancho,
            enemigo.alto
        )then
            atrapado = true
            MaquinaEstadoGlobal:cambiar('derrota')
        end
    end
end
function EstadoJugar:dibujar()
    love.graphics.setCanvas(lienzo)
        love.graphics.clear()
        self.jugador:Dibujar()
        for i, enemigo in ipairs(self.enemigos) do
            enemigo:Dibujar()
        end

        if depurar then
            love.graphics.setColor(1, 0, 0)
            self.jugador:Debug()
            for i, enemigo in ipairs(self.enemigos) do
                enemigo:Debug()
            end
            love.graphics.setColor(1, 1, 1)
        end
    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)
    if depurar then
        debugUI()
    end
end