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
require 'app/fabrica_navio'
require 'app/coordenada'
require 'app/fabrica_grade'
require 'app/campo'

class CampoTest < Test::Unit::TestCase
  def test_deve_receber_grade
    g = criar_grade
    c = Campo.new g
    assert_not_nil c.grade
  end

  def test_deve_inicializar_array_de_navios
    g = criar_grade
    c = Campo.new g
    assert_not_nil c.navios
  end

  def test_deve_posicionar_navio_horizontal
    campo = criar_campo
    n = criar_navio
    x = y = 0
    co = Coordenada.new x,y,:horizontal
    campo.posicionar_navio n, co

    n.tamanho.times do |i|
      assert_not_nil campo.grade[x][y+i].parte_navio
    end
    assert_not_nil campo.navios[0]
  end

  def test_deve_posicionar_navio_vertical
    campo = criar_campo
    n = criar_navio
    x = y = 0
    co = Coordenada.new x,y,:vertical
    campo.posicionar_navio n, co

    n.tamanho.times do |i|
      assert_not_nil campo.grade[x+i][y].parte_navio
    end
    assert_not_nil campo.navios[0]
  end

  def test_deve_falhar_para_coordenada_invalida
    campo = criar_campo
    n = criar_navio
    co = Coordenada.new 0,0,:invalido
    assert_raise RuntimeError, LoadError do
      campo.posicionar_navio n, co
    end
  end

  def test_deve_acertar_navio
    campo = inicializar_campo
    m = campo.atacar! "A1"
    assert_match /^Um navio/, m
  end

  def test_deve_acertar_agua
    campo = inicializar_campo
    m = campo.atacar! "2A"
    assert_match /^Nenhum navio/, m
  end

  def test_deve_destruir_navio
    campo = inicializar_campo
    n = criar_navio
    n.tamanho.times do |i|
      m = campo.atacar! "1#{Coordenada.num2char(i)}"
      assert_match /^Um navio/, m
      if i == n.tamanho
        assert_match /^O navio #{n.nome}/, m
      end
    end
  end

  private
  def criar_grade(x=10,y=10)
    FabricaGrade.construir_grade x, y
  end

  def criar_campo(x=10,y=10)
    Campo.new criar_grade(x, y)
  end

  def criar_navio(tipo=:fragata)
    FabricaNavio.construir_navio tipo
  end

  def inicializar_campo
    campo = Campo.new criar_grade
    n = criar_navio
    co = Coordenada.new 0,0,:horizontal
    campo.posicionar_navio n, co
    campo
  end
end
