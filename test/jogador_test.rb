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
require 'app/jogador'
require 'app/fabrica_grade'
require 'app/fabrica_navio'
require 'app/coordenada'

class JogadorTest < Test::Unit::TestCase
  def test_deve_receber_nome_e_campo_na_inicializacao
    campo = criar_campo
    nome = 'Steve'
    j = Jogador.new nome, campo
    assert_equal nome, j.nome
  end

  def test_deve_receber_ataque
    j = criar_jogador
    m = j.receber_ataque "A1"
    assert_match /^Um navio/, m
  end

  def test_deve_imprimir_campo
    j = criar_jogador
    j.receber_ataque "A1"
    c = j.imprimir_campo j.nome
    assert_match /^| \[X\]/, c
  end

  def test_deve_imprimir_campo_rival
    j = criar_jogador
    j.receber_ataque "a1"
    c = j.imprimir_campo('jogador rival')
    assert_match /^|  X  /, c
  end

  def test_jogador_perde_quando_todos_navios_forem_destruidos
    j = criar_jogador
    n = criar_navio
    n.tamanho.times do |i|
      j.receber_ataque "1#{Coordenada.num2char(i)}"
    end
    assert j.perdeu?
  end

  private
  def criar_campo
    g = FabricaGrade.construir_grade 10,10
    Campo.new g
  end

  def criar_navio(tipo = :fragata)
    FabricaNavio.construir_navio tipo
  end

  def criar_jogador(nome='Steve')
    c = criar_campo
    n = criar_navio
    co = Coordenada.parse "A1"
    c.posicionar_navio n, co
    Jogador.new nome, c
  end
end
