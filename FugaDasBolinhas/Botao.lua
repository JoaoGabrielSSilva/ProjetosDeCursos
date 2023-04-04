local love = require "love"

function Botao(texto, func, func_param, largura, altura)
  return {
    largura = largura or 100,
    altura = altura or 100,
    func = func or function() print("Esse botão não tem função") end,
    func_param = func_param,
    texto = texto or "Sem texto",
    botao_x = 0,
    botao_y = 0,
    texto_x = 0,
    texto_y = 0,

    checarPressionado = function (self, mouse_x, mouse_y, cursor_raio)
      if (mouse_x + cursor_raio >= self.botao_x) and (mouse_x - cursor_raio <= self.botao_x + self.largura) then
        if (mouse_y + cursor_raio >= self.botao_y) and (mouse_y - cursor_raio <= self.botao_y + self.altura) then
          if self.func_param then
            self.func(self.func_param)
          else
            self.func()
          end
        end
      end
    end,

    desenha = function (self, botao_x, botao_y, texto_x, texto_y)
      self.botao_x = botao_x or self.botao_x
      self.botao_y = botao_y or self.botao_y

      if texto_x then
        self.texto_x = texto_x + self.botao_x
      else
        self.texto_x = self.botao_x
      end

      if texto_y then
        self.texto_y = texto_y + self.botao_y
      else
        self.texto_y = self.botao_y
      end

      love.graphics.setColor(0.6, 0.6, 0.6)

      love.graphics.rectangle("fill", self.botao_x, self.botao_y, self.largura, self.altura)

      love.graphics.setColor(0, 0, 0)
      love.graphics.print(self.texto, self.texto_x, self.texto_y)

      love.graphics.setColor(1, 1, 1)
    end
  }
end

return Botao