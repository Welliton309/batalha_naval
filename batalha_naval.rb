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

require 'app/parte_navio'
require 'app/navio'
require 'app/fabrica_navio'
require 'app/coordenada'
require 'app/quadrante'

class BatalhaNaval
  attr_accessor :partida_espera, :id_partida, :partidas

  def initialize
    @partida_espera = nil
    @id_partida = nil
    @partidas = Hash.new
  end

  def jogar(nome, navios, coordenadas)
    if @partida_espera.nil?
      @partida_espera = Partida.new
      @id_partida = @partidas.keys.size
      @partidas[@id_partida] = @partida_espera
      @partida_espera.entrar nome, navios, coordenadas
    else
      @partida_espera.entrar nome, navios, coordenadas
      @partida_espera = nil
    end
    @id_partida
  end
  
  def atacar(id,nome,x,y)
    partida(id).atacar(nome,x,y)
  end
  
  def imprimir_campos(id, nome)
    partida(id).imprimir_campos(nome)
  end
  
  private
  def partida(id)
    unless @partidas.key? id
      raise "Partida não encontrada"
    end
    @partidas[id]
  end
end

#testes
jogo = BatalhaNaval.new

felipe = "Steve"
navios_felipe = Array.new
navios_felipe << FabricaNavio.construir_navio(:submarino)
coordenadas_navios_felipe = Array.new
coordenadas_navios_felipe << Coordenada.new(0,0,:horizontal)
jogo.jogar felipe, navios_felipe, coordenadas_navios_felipe

nome1 = "Lito"
coordenadas = Array.new
navios = Array.new
coordenadas << Coordenada.new(0,0,:horizontal)
navios << FabricaNavio.construir_navio(:porta_avioes)
coordenadas << Coordenada.new(2,5,:vertical)
navios << FabricaNavio.construir_navio(:fragata)
coordenadas << Coordenada.new(5,8,:vertical)
navios << FabricaNavio.construir_navio(:cruzador)
id = jogo.jogar nome1, navios, coordenadas

puts "Jogadores: #{jogo.partidas[id].jogador1.nome} #{jogo.partidas[id].jogador2.nome}"

jogadores = [nome1,felipe]
while(1) do
  jogador = jogadores.shift
  puts "#{jogador}"
  print "Coordenada x: "
  x = gets.chomp.to_i() -1
  print "Coordenada y: "
  y = gets.chomp
  puts jogo.atacar(id, jogador, x, y)
  puts jogo.imprimir_campos(id, jogador)
  jogadores << jogador
end
