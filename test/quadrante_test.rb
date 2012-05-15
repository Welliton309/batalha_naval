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

require 'app/quadrante'
require 'app/navio'
require 'app/parte_navio'
require 'test/unit'

class QuadranteTest < Test::Unit::TestCase
  def test_deve_inicializar_atacado_como_falso
    q = Quadrante.new
    assert_equal false, q.atacado?
  end

  def test_deve_inicializar_parte_navio_como_nil
    q = Quadrante.new
    assert_nil q.parte_navio
  end

  def test_deve_acatar_quadrante
    q = Quadrante.new
    q.atacar!
    assert q.atacado?
  end

  def test_deve_atacar_parte_navio_no_quadrante
    q = Quadrante.new
    q.parte_navio = criar_parte_navio
    q.atacar!
    assert q.parte_navio.destruida?
  end

  private
  def criar_parte_navio
    n = Navio.new 'fragata'
    ParteNavio.new n
  end
end
