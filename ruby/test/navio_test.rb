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
require 'app/navio'
require 'app/parte_navio'

class NavioTest < Test::Unit::TestCase
  
  def test_deve_receber_um_nome_na_inicializacao
    nome = 'Fragata'
    navio = Navio.new nome
    assert_equal nome, navio.nome
  end

  def test_deve_retornar_tamanho_do_navio
    tamanho = 5
    navio = Navio.new 'Fragata'
    navio.partes = criar_partes tamanho
    assert_equal tamanho, navio.tamanho
  end

  def test_deve_retornar_destruido_se_todas_as_partes_estiverem_destruidas
    navio = criar_navio
    navio.partes = criar_partes
    destruir_partes navio.partes
    assert navio.destruido?
  end

  def test_deve_destruir_navio
    navio = criar_navio
    navio.partes = criar_partes
    navio.destruir!
    assert navio.destruido?
  end

  private
  def destruir_partes partes
    partes.each_index do |i|
      partes[i].atacar!
    end
  end

  def criar_navio nome = 'Fragata'
    Navio.new nome
  end

  def criar_partes tamanho = 5
    navio = criar_navio
    partes = Array.new tamanho
    partes.each_index do |i|
      partes[i] = ParteNavio.new navio
    end
    partes
  end
end
