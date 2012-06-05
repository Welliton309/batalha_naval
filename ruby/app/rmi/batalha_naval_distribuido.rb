#!/usr/bin/env ruby

# Copyright 2012 Welliton de Souza
#
# Este programa é um software livre; você pode redistribui-lo e/ou 
# modifica-lo dentro dos termos da Licença Pública Geral GNU como 
# publicada pela Fundação do Software Livre (FSF); na versão 2 da 
# Licença, ou (na sua opnião) qualquer versão.
#
# Este programa é distribuido na esperança que possa ser  util, 
# mas SEM NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a
# Licença Pública Geral GNU para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU
# junto com este programa, se não, escreva para a Fundação do Software
# Livre(FSF) Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

require 'app/partida'
require 'app/regra'
require 'app/batalha_naval'

class BatalhaNavalDistribuido
  def initialize
    @jogo = BatalhaNaval.new
    @partidas_espera = Array.new
  end

  def jogar(nome, coordenadas)
    id = @jogo.jogar(nome, coordenadas)
    esperar_jogador id
    id
  end

  def atacar(id, nome, coordenadas)
    m = @jogo.atacar id, nome, coordenadas
    esperar_jogador(id)
    m
  end

  def ordem_navios
    @jogo.ordem_navios
  end

  def imprimir_campos(id, nome)
    @jogo.imprimir_campos(id,nome)
  end

  def ativo?(id)
    @jogo.ativo? id
  end

  private
  def esperar_jogador(id)
    if @partidas_espera.include? id
      @partidas_espera.delete id
    else
      @partidas_espera << id
      while @partidas_espera.include? id 
        sleep(1)
      end
    end
  end
end
