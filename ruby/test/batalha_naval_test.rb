#!/usr/bin/env ruby

# Copyright 2012 Welliton de Souza
#
# Este arquivo é parte do programa BatalhaNaval
#
# BatalhaNaval é um software livre; você pode redistribui-lo e/ou 
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
require 'app/batalha_naval'

class BatalhaNavalTest < Test::Unit::TestCase
  def test_deve_inicializar_atributos
    b = BatalhaNaval.new
    assert_nil b.partida_espera
    assert_nil b.id_partida
    assert_not_nil b.partidas
  end

  def test_deve_iniciar_regra_padrao
    b = BatalhaNaval.new
    assert_equal 10, b.regra.tamanho_x
    assert_equal 10, b.regra.tamanho_y
    assert_not_nil b.regra.navios
  end

  def test_jogar
    b = criar_jogo
    nome = jogadores
    coordenadas = criar_coordenadas
    b.jogar(nome.shift, coordenadas)
  end

  private
  def criar_jogo
    BatalhaNaval.new
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
end
