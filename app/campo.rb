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

class Campo
  attr_accessor :grade
  
  def initialize(grade)
    @grade = grade
  end
  
  def posicionar_navio(navio, coordenada)
    orientacao = coordenada.orientacao
    if orientacao.eql? :horizontal
      navio.tamanho.times do |i|
        @grade[coordenada.x][coordenada.y + i].parte_navio = navio.partes[i]
      end
    elsif orientacao.eql? :vertical
      navio.tamanho.times do |i|
        @grade[coordenada.x + i][coordenada.y].parte_navio = navio.partes[i]
      end
    else
      raise "Coordenada invalida."
    end
  end
  
  def imprimir_rival
    saida = "\n"
    header = "     "  
    count = 1
    @grade.each do |x|
      saida << "%2d " % count
      header << "#{Coordenada.num2char(count-1)}   "
      count += 1
      x.each do |y|
        c = nil
        if y.atacado?
          if y.parte_navio.nil?
            c = "\e[34mO\e[0m"
          else
            c = "\e[31mX\e[0m"
          end
        else
          c = ' '
        end
        saida << "| #{c} "
      end
      saida << "|\n"
    end
    header << saida
  end
  
  def imprimir
    saida = "\n"
    header = "     "
    count = 1
    @grade.each do |x|
      saida << "%2d " % count
      header << "#{Coordenada.num2char(count-1)}   "
      count += 1
      x.each do |y|
        c = nil
        if y.parte_navio.nil?
          if y.atacado?
            c = " \e[34mO\e[0m "
          else
            c = '   '
          end
        else
          if y.atacado?
            c = "\e[31m[X]\e[0m"
          else
            c = '[ ]'
          end
        end
        saida << "|#{c}"
      end
      saida << "|\n"
    end
    header << saida
  end
  
  def atacar!(coordenada)
    if coordenada.is_a? Coordenada
      c = coordenada
    else
      c = Coordenada.parse coordenada
    end
    quadrante = @grade[c.x][c.y]
    quadrante.atacar!
    mensagem = nil
    if quadrante.parte_navio.nil?
      mensagem = "Nenhum navio foi atingido durante o ataque!\n"
    else
      mensagem = "Um navio inimigo foi atingido durante o ataque!\n"
      navio = quadrante.parte_navio.navio
      if navio.destruido?
        mensagem << "O navio #{navio.nome} foi destruido!\n"
      end
    end
    mensagem
  end
end
