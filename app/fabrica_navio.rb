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

require 'app/parte_navio'
require 'app/navio'

class FabricaNavio
  def self.construir_navio(tipo)
    tamanho = 0
    nome = nil
    if tipo.eql? :porta_avioes
      tamanho = 6
      nome = "Porta Aviões"
    elsif tipo.eql? :fragata
      tamanho = 5
      nome = "Fragata"
    elsif tipo.eql? :cruzador
      tamanho = 4
      nome = "Cruzador"
    elsif tipo.eql? :destroyer
      tamanho = 3
      nome = "Destroyer"
    elsif tipo.eql? :submarino
      tamanho = 2
      nome = "Submarino"
    else
      raise "Tipo invalido."
    end
    navio = Navio.new nome
    partes = Array.new tamanho
    partes.each_index do |i|
      partes[i] = ParteNavio.new(navio)
    end
    navio.partes = partes
    navio
  end
end

