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

#require 'app/navio'
#require 'app/fabrica_navio'
#require 'app/coordenada'
#require 'app/quadrante'
require 'app/fabrica_grade'
require 'app/campo'

class Jogador
  attr_accessor :nome

  def initialize(nome, campo)
    @nome = nome
    @campo = campo
  end
	
  def receber_ataque(coordenada)
    @campo.atacar! coordenada
  end

  def imprimir_campo(nome)
    if nome.eql? @nome
      @campo.imprimir
    else
      @campo.imprimir_rival
    end
  end
  
  def perdeu?
    perdeu = true
    @campo.navios.each do |navio|
      unless navio.destruido?
        perdeu = false
        break
      end
    end
    perdeu
  end
end
