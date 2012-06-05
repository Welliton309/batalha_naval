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
require 'app/parte_navio'
require 'app/navio'

class ParteNavioTest < Test::Unit::TestCase
  

  def test_deve_receber_navio_na_inicializacao
    navio = Navio.new 'Fragata'
    parte = ParteNavio.new navio
    assert_not_nil parte.navio
  end

  def test_deve_inicializar_destruido_como_falso
    parte = criar_parte
    assert_equal false, parte.destruida? 
  end

  def test_deve_deve_destruir_parte_quando_atacada
    parte = criar_parte
    parte.atacar!
    assert parte.destruida?
  end
  
  private
  def criar_parte
    navio = Navio.new 'Fragata'
    ParteNavio.new navio
  end
end
