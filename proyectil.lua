Proyectil = Class{}

function Proyectil:init(x, y, angulo, velocidad)
    self.x = x
    self.y = y
    self.radio = 4
    self.dx = math.cos(angulo)
    self.dy = math.sin(angulo)
    self.velocidad = velocidad
    self.color = {math.random(), math.random(), math.random()}
end

function Proyectil:Actualizar(dt)
    self.x = self.x + self.dx * self.velocidad * dt
    self.y = self.y + self.dy * self.velocidad * dt
end

function Proyectil:Dibujar()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", math.floor(self.x), math.floor(self.y), self.radio)
    love.graphics.setColor(1, 1, 1)
end