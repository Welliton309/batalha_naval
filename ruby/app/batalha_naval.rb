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

require 'app/partida'
require 'app/regra'

class BatalhaNaval
  attr_accessor :partida_espera, :id_partida, :partidas, :regra

  def initialize(regra = Regra.new)
    @partida_espera = nil
    @id_partida = nil
    @partidas = Hash.new
    @regra = regra
  end

  def jogar(nome, coordenadas)
    if @partida_espera.nil?
      @partida_espera = Partida.new(regra)
      @id_partida = @partidas.keys.size
      @partidas[@id_partida] = @partida_espera
      @partida_espera.entrar nome, coordenadas
    else
      @partida_espera.entrar nome, coordenadas
      @partida_espera.iniciar!
      @partida_espera = nil
    end
    @id_partida
  end
  
  def atacar(id,nome,coordenada)
    partida(id).atacar(nome,coordenada)
  end
  
  def imprimir_campos(id, nome)
    partida(id).imprimir_campos(nome)
  end

  def ordem_navios
    regra.navios
  end

  def ativo?(id)
    partida(id).ativa?
  end
  
  def partida(id)
    unless @partidas.key? id
      raise "Partida não encontrada: #{id}"
    end
    @partidas[id]
  end
end
