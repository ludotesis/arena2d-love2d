-- =================== "CLASE"  ENEMIGO ===================
Enemigo = {}
Enemigo.__index = Enemigo
-- =================== INICIALIZACION ===================
function Enemigo:Nuevo(x, y ,img)
    --local o = {}
    local o = setmetatable({}, Enemigo)

    o.x = x
    o.y = y
    o.sprite = love.graphics.newImage(img)
    o.ancho = o.sprite:getWidth()
    o.alto  = o.sprite:getHeight()
    o.origen_x = o.ancho/2
    o.origen_y = o.alto/2
    o.hitbox_x = 0
    o.hitbox_y = 0
    o.velocidad = 40

    return o
end
-- =================== ACTUALIZAR ===================
function  Enemigo:Actualizar(x,y,a,dt)
    -- Persecución
    local dist_x = math.abs(self.x - x)
    local dist_y = math.abs(self.y - y)

    if dist_x > dist_y then
        if dist_x > a then
            if self.x < x then
                self.x = self.x + (self.velocidad * dt)
            elseif self.x > x then
                self.x = self.x - (self.velocidad * dt)
            end
        end
    else
        if dist_y > a then
            if self.y < y then
                self.y = self.y + (self.velocidad * dt)
            elseif self.y > y then
                self.y = self.y - (self.velocidad * dt)
            end
        end
    end

    self.hitbox_x = self.x - self.origen_x
    self.hitbox_y = self.y - self.origen_y
end
-- =================== RENDERIZADO ===================
function Enemigo:Dibujar()
    love.graphics.draw(self.sprite,redondear(self.x),redondear(self.y),0, 1, 1, self.origen_x, self.origen_y)
end


-- =================== DEPURAR ===================
function Enemigo:Debug()
    love.graphics.rectangle("line", redondear(self.hitbox_x), redondear(self.hitbox_y), self.ancho, self.alto)
    love.graphics.circle("fill", redondear(self.x), redondear(self.y), 1)
end
-- =================== OBJETOS ===================
--[[
enemigo1 =
{
    crear = Enemigo.Crear,
    actualizar = Enemigo.Actualizar,
    dibujar = Enemigo.Dibujar
}

enemigo2 =
{
    crear = Enemigo.Crear,
    actualizar = Enemigo.Actualizar,
    dibujar = Enemigo.Dibujar
}

enemigo3 =
{
    crear = Enemigo.Crear,
    actualizar = Enemigo.Actualizar,
    dibujar = Enemigo.Dibujar
}
]]