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

require 'app/jogador'
require 'app/regra'
require 'app/campo'
require 'app/fabrica_grade'
require 'app/fabrica_navio'
require 'app/coordenada'

class Partida
  attr_accessor :regra
  
  def initialize(regra = Regra.new)
    @regra = regra
    @ativa = false
  end
  
  def entrar(nome, coordenadas)
    if @jogador1.nil?
      @jogador1 = iniciar_jogador(nome, coordenadas)
    elsif @jogador2.nil?
      @jogador2 = iniciar_jogador(nome, coordenadas)
    else
      raise "Apenas dois jogadores por partidas"
    end
  end
  
  def atacar(nome, coordenada)
    mensagem = ''
    if ativa?
      jogador = jogador_rival(nome)
      mensagem = jogador.receber_ataque(coordenada)
    else
      mensagem = "O jogo acabou!\n"
    end
    mensagem << verificar_partida(nome)
    mensagem
  end

  def imprimir_campos(nome)
    saida = "Seu campo: \n"
    saida << jogador(nome).imprimir_campo(nome)
    saida << "Campo rival: \n"
    saida << jogador_rival(nome).imprimir_campo(nome)
  end

  def verificar_partida(nome)
    mensagem = ""
    if jogador(nome).perdeu?
      mensagem = "Voce perdeu!\n"
      acabar!
    elsif jogador_rival(nome).perdeu?
      mensagem = "Voce venceu!\n"
      acabar!
    end
    mensagem
  end

  def iniciar!
    if @jogador1.nil? or @jogador2.nil?
      raise "Falta jogadores."
    end
    @ativa = true
  end

  def acabar!
    @ativa = false
  end

  def ativa?
    @ativa
  end

  private
  def jogador_rival(nome)
    jogador = nil
    if @jogador1.nome.eql? nome
      jogador = @jogador2
    elsif @jogador2.nome.eql? nome
      jogador = @jogador1
    else
      raise "Jogador invalido: #{nome}"
    end
    jogador
  end
  
  def jogador(nome)
    jogador = nil
    if @jogador1.nome.eql? nome
      jogador = @jogador1
    elsif @jogador2.nome.eql? nome
      jogador = @jogador2
    else
      raise "Jogador invalido"
    end
    jogador
  end

  def criar_campo
    x = @regra.tamanho_x
    y = @regra.tamanho_y
    grade = FabricaGrade.construir_grade x,y
    Campo.new grade
  end

  def iniciar_campo(campo, coordenadas)
    navios = @regra.navios
    navios.each_index do |i|
      tipo = navios[i]
      navio = FabricaNavio.construir_navio tipo
      coordenada = coordenadas[i]
      campo.posicionar_navio navio, Coordenada.parse(coordenada)
    end
  end

  def iniciar_jogador(nome, coordenadas)
    campo = criar_campo
    iniciar_campo(campo, coordenadas)
    Jogador.new nome, campo
  end
end
