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

require 'test/unit'
require 'app/partida'
require 'app/regra'

class PartidaTest < Test::Unit::TestCase
  def test_regra_padrao
    p = Partida.new
    r = Regra.new
    assert r.tamanho_x, p.regra.tamanho_x
    assert r.tamanho_y, p.regra.tamanho_y
    assert r.navios.size, p.regra.navios.size
  end

  def test_deve_iniciar_partida_como_falso_na_inicializacao
    p = Partida.new
    assert_equal false, p.ativa?
  end

  def test_deve_inciar_partida_apenas_se_houverem_jogadores
    p = Partida.new
    assert_raise RuntimeError, LoadError do
      p.iniciar!
    end
    coordenadas = criar_coordenadas
    p.entrar 'Steve', coordenadas
    assert_raise RuntimeError, LoadError do
      p.iniciar!
    end
    p.entrar 'Bill', coordenadas
    p.iniciar!
    assert p.ativa?
  end

  def test_deve_atacar_campo_rival
    p = iniciar_partida
    j = jogadores.shift
    m = p.atacar(j, "A#{1}")
    assert_match /^Um navio/, m
  end

  def test_deve_parar_jogo
    p = iniciar_partida
    jogador = jogadores.shift
    p.regra.tamanho_x.times do |i|
      p.regra.tamanho_y.times do |j|
        p.atacar(jogador, "#{i+1}#{Coordenada.num2char(j)}")
      end
    end
    assert_equal false, p.ativa?
    assert_match /venceu/, p.verificar_partida(jogador)
  end

  private
  def criar_partida
    Partida.new
  end

  def criar_coordenadas
    r = Regra.new
    coordenadas = []
    r.navios.each_index do |i|
      coordenadas << "A#{i+1}"
    end
    coordenadas
  end

  def jogadores
    ['Steve', 'Bill'].shuffle
  end

  def iniciar_partida
    p = criar_partida
    coordenadas = criar_coordenadas
    jogadores.each do |nome|
      p.entrar nome, coordenadas
    end
    p.iniciar!
    p
  end
end
