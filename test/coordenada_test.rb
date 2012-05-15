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
require 'app/coordenada'

class CoordenadaTest < Test::Unit::TestCase
  def test_deve_inicializar_orientacao_horizontal_quando_nao_informado
    c = Coordenada.new(0,0)
    assert_equal :horizontal, c.orientacao
  end

  def test_valor_de_x_deve_ser_maior_que_0
    assert_raise RuntimeError, LoadError do
      Coordenada.new(-1,0)
    end
  end

  def test_valor_de_y_deve_ser_maior_que_0
    assert_raise RuntimeError, LoadError do
      Coordenada.new(0,-1)
    end
  end

  def test_deve_retornar_respectiva_letra
    count = 0
    ('A'..'Z').to_a.each do |i|
      assert_equal i, Coordenada.num2char(count)
      count += 1
    end
  end

  def test_deve_retornar_respectivo_numero
    arr = ('A'..'Z').to_a
    count = 0
    arr.each do |i|
      assert_equal count, Coordenada.char2num(i)
      count += 1
    end
  end

  def test_deve_retornar_objeto_coordenada
    c = Coordenada.parse "3B"
    assert_equal 2, c.x
    assert_equal 1, c.y
  end

  def test_deve_retornar_objeto_coordenada_valores_trocados
    c = Coordenada.parse "B3"
    assert_equal 2, c.x
    assert_equal 1, c.y
  end

  def test_parser_deve_falhar_para_entradas_invalidas
    assert_raise RuntimeError, LoadError do
      Coordenada.parse "3\n"
    end
  end
end
