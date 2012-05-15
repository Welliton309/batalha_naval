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

require 'drb'

DRb.start_service

jogo = DRbObject.new nil, ARGV.shift

puts "Batalha Naval"
print "Seu nome: "
$stdout.flush
nome = gets.chomp

navios = jogo.ordem_navios

puts "Informe as cordenadas para,"
coordenadas = []
navios.each do |tipo|
  print "#{tipo}: "
  $stdout.flush
  coordenadas << gets.chomp
end

puts "Entrando no jogo.."
id = jogo.jogar nome, coordenadas
puts jogo.imprimir_campos(id, nome)

while jogo.ativo? id
  print "Atacar coordenada: "
  $stdout.flush
  coordenada = gets.chomp
  puts jogo.atacar(id,nome,coordenada)
  puts jogo.imprimir_campos(id,nome)
end
