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
require 'app/fabrica_navio'

class FabricaNavioTest < Test::Unit::TestCase
  def test_deve_criar_porta_avioes_com_tamanho_6
    navio = construir :porta_avioes
    verificar navio, "Porta Aviões", 6
  end

  def test_deve_criar_fragata_com_tamanho_5
    navio = construir :fragata
    verificar navio, "Fragata", 5
  end

  def test_deve_criar_cruzador_com_tamanho_4
    navio = construir :cruzador
    verificar navio, "Cruzador", 4
  end

  def test_deve_criar_destroyer_com_tamanho_3
    navio = construir :destroyer
    verificar navio, "Destroyer", 3
  end

  def test_deve_criar_submarino_com_tamanho_2
    navio = construir :submarino
    verificar navio, "Submarino", 2
  end

  def test_deve_larcar_excessao_para_tipo_invalido
    assert_raise RuntimeError, LoadError do
      construir :invalido
    end
  end



  private
  def construir tipo
    FabricaNavio.construir_navio tipo
  end

  def verificar navio, nome_esperado, tamanho_esperado
    assert_equal nome_esperado, navio.nome
    assert_equal tamanho_esperado, navio.tamanho
    verificar_partes navio.partes
    
  end

  def verificar_partes partes
    partes.each do |parte|
      assert_not_nil parte
    end
  end
end
