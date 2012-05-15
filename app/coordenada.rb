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

class Coordenada
  attr_accessor :x, :y, :orientacao
  
  def initialize(x,y,orientacao=:horizontal)
    if x < 0 or y < 0
      raise "As coordenadas não podem ser valores negativos"
    end
    @x = x
    @y = y
    @orientacao = orientacao
  end

  def self.num2char(number)
    ('A'..'Z').to_a[number]
  end
  
  def self.char2num(letra)
    ('A'..'Z').to_a.to_s.index(letra.upcase)
  end

  def self.parse(coordenada, orientacao=:horizontal)
    begin
      x = /(\d+)/.match(coordenada)[1]
      y = /(\D+)/.match(coordenada)[1]
      Coordenada.new(x.to_i() - 1, char2num(y), orientacao)
    rescue
      raise "Coordenada invalida."
    end
  end
end
