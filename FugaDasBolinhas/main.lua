local love = require "love"
local Inimigo = require "Inimigo"
local Botao = require "Botao"

math.randomseed(os.time())

local jogo = {
  dificuldade = 1,
  estado = {menu = true,
    pausado = false,
    rodando = false, 
    finalizado = false},
  pontos = 0,
  niveis = {15, 30, 60, 120}
}

local fontes = {
  media = {
    font = love.graphics.newFont(16),
    size = 16
  },
  grande = {
    font = love.graphics.newFont(24),
    size = 24
  },
  gigante = {
    font = love.graphics.newFont(69),
    size = 60
  }
}

local jogador = {
  raio = 20,
  x = 30,
  y = 30
}

local botoes = {
  menu_estado = {},
  fim_estado = {}
}

local inimigos = {}

local function MudarEstado(estado)
  jogo.estado["menu"] = estado == "menu"
  jogo.estado["pausado"] = estado == "pausado"
  jogo.estado["rodando"] = estado == "rodando"
  jogo.estado["finalizado"] = estado == "finalizado"

end

local function IniciarJogo()
  MudarEstado("rodando")
  jogo.pontos = 0
  inimigos = {
    Inimigo(1)
  }
end


function love.mousepressed(x, y, button, estaTocado, aperta)
  if not jogo.estado["rodando"] then
    if button == 1 then
      if jogo.estado["menu"] then
        for indice in pairs(botoes.menu_estado) do
          botoes.menu_estado[indice]:checarPressionado(x, y,jogador.raio)
        end 
      end
      if jogo.estado["finalizado"] then
        for indice in pairs(botoes.fim_estado) do
          botoes.fim_estado[indice]:checarPressionado(x, y,jogador.raio)
        end 
      end
    end
  end
end

function love.load()
  love.mouse.setVisible(false)

  botoes.menu_estado.jogar = Botao("Jogar", IniciarJogo, nil, 120, 40)
  botoes.menu_estado.opcoes = Botao("Opções", nil, nil, 120, 40)
  botoes.menu_estado.sair = Botao("Sair", love.event.quit, nil, 120, 40)

  botoes.fim_estado.replay = Botao("Jogar Novamente", IniciarJogo, nil, 300, 40)
  botoes.fim_estado.menu = Botao("Menu", MudarEstado, "menu", 300, 40)
  botoes.fim_estado.sair = Botao("Sair", love.event.quit, nil, 300, 40)
  
end

function love.update(dt)
  jogador.x, jogador.y = love.mouse.getPosition()
  if jogo.estado["rodando"] then
    for i  = 1, #inimigos do
      if not inimigos[i]:checarTocado(jogador.x, jogador.y, jogador.raio) then
        inimigos[i]:move(jogador.x, jogador.y)

        for i = 1, #jogo.niveis do
          if math.floor(jogo.pontos) == jogo.niveis[i] then
            table.insert(inimigos, 1, Inimigo(jogo.dificuldade * (i + 1)))

            jogo.pontos = jogo.pontos + 1
          end
        end -- mudar depois a forma de pontos
      else
        MudarEstado("finalizado")
      end
      
    end
    jogo.pontos = jogo.pontos + dt
  end
end

function love.draw()
  love.graphics.setFont(fontes.media.font)
  --Contador de FPS
  love.graphics.printf("FPS: " .. love.timer.getFPS(), fontes.media.font, 10, love.graphics.getHeight() -30, love.graphics.getWidth())

  if jogo.estado["rodando"] then

    love.graphics.printf(math.floor(jogo.pontos), fontes.grande.font, 0, 10, love.graphics.getWidth(), "center")

    for i  = 1, #inimigos do
      inimigos[i]:desenha()
    end
    
    --Desenhando o Jogador
      --Corpo
    love.graphics.setColor(209 / 255, 150 / 255, 105 / 255)
    love.graphics.circle("fill", jogador.x, jogador.y, jogador.raio)

    love.graphics.setColor(1, 1, 1)

  elseif jogo.estado["menu"] then
    botoes.menu_estado.jogar:desenha(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.8, 40, 10)
    botoes.menu_estado.opcoes:desenha(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.54, 25, 10)
    botoes.menu_estado.sair:desenha(love.graphics.getWidth() / 2.25, love.graphics.getHeight() / 1.33, 40, 10)
  elseif jogo.estado["finalizado"] then
    love.graphics.setFont(fontes.grande.font)
    botoes.fim_estado.replay:desenha(love.graphics.getWidth() / 3, love.graphics.getHeight() / 1.8, 45, 5)
    botoes.fim_estado.menu:desenha(love.graphics.getWidth() / 3, love.graphics.getHeight() / 1.54, 120, 10)
    botoes.fim_estado.sair:desenha(love.graphics.getWidth() / 3, love.graphics.getHeight() / 1.33 , 130, 10)

    love.graphics.printf(math.floor(jogo.pontos), fontes.gigante.font, 0, love.graphics.getHeight() / 2 - fontes.gigante.size, love.graphics.getWidth(), "center")
  end
  --Jogo
  if not jogo.estado["rodando"] then
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", jogador.x, jogador.y, jogador.raio / 2)
  end
end
