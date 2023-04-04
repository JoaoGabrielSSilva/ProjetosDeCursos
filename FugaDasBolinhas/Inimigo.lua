local love = require "love"

function Inimigo(nivel)
  local dado = math.random(1, 4)
  local _x, _y
  local _raio = 20

  if dado == 1 then
    _x = math.random(_raio, love.graphics.getWidth())
    _y = -_raio * 4

  elseif dado == 2 then
    _x = -_raio * 4
    _y = math.random(_raio, love.graphics.getHeight())

  elseif dado == 3 then
    _x = math.random(_raio, love.graphics.getWidth())
    _y = love.graphics.getHeight() + (_raio * 4)

  else
    _x = love.graphics.getWidth() + (_raio * 4) 
    _y = math.random(_raio, love.graphics.getHeight())
  end

  return {
    nivel = nivel or 1,
    raio = _raio,
    x = -_x,
    y = _y,

    checarTocado = function (self, jogador_x, jogador_y, raio_cursor)
      return math.sqrt((self.x - jogador_x) ^ 2 + (self.y - jogador_y) ^ 2 ) <= raio_cursor * 2
    end,

    move = function (self, jogador_x, jogador_y)
      if jogador_x - self.x > 0 then
        self.x = self.x + self.nivel
      elseif jogador_x - self.x < 0 then
        self.x = self.x - self.nivel
      end

      if jogador_y - self.y > 0 then
        self.y = self.y + self.nivel
      elseif jogador_y - self.y < 0 then
        self.y = self.y - self.nivel
      end
    end,

    desenha = function (self)
      love.graphics.setColor(27 / 255, 77 / 255, 13 / 255)
      love.graphics.circle("fill", self.x, self.y, self.raio)

      love.graphics.setColor(100 / 255, 107 / 255, 97 / 255)
    end
      
  }
end

return Inimigo