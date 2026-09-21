HUD = Class{}

function HUD:init(mundo)
    self.texto_vida = ""
    self.mundo = mundo
    self.depurar = false
    -- Subscribir eventos
    --love.handlers.modoDebug = self.DebugToggle
    --love.handlers.actualizarVidas = self.ActualizarVidas
    love.handlers.modoDebug = function() self:DebugToggle() end
    love.handlers.actualizarVidas = function(vidas) self:ActualizarVidas(vidas) end
end

function HUD:Draw()
    love.graphics.print(self.texto_vida, 300, 10)
end

function HUD:DrawGameData()
    if not self.depurar then  return  end

    love.graphics.setColor(0, 1, 0)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    if atrapado then
        love.graphics.print("ATRAPADO", 100, 10)
    end
    love.graphics.setColor(1, 1, 1)
end

function HUD:DrawHitboxes()
    if not self.depurar then  return  end

    local items = self.mundo:getItems()
    for _, item in ipairs(items) do
        local x, y, ancho, alto = mundo:getRect(item)
        love.graphics.rectangle("line", redondear(x), redondear(y), ancho, alto)
    end
end

function HUD:DebugToggle()
    self.depurar = not self.depurar
end

function HUD:ActualizarVidas(vidas)
    self.texto_vida = "x"..vidas
end