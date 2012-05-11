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

def number_to_alpha(number)
	('A'..'Z').to_a[number]
end

def alpha_to_number(letra)
	('A'..'Z').to_a.to_s.index(letra.upcase)
end

class ParteNavio
	attr_accessor :destruido, :navio

	def initialize(navio)
		@navio = navio
		@destruido = false
	end

	def destruido?
		@destruido
	end
end

class Navio
  attr_accessor :nome, :partes
  
  def initialize(nome)
    @nome = nome
  end
  
  def tamanho
    partes.size
  end
  
  def destruido?
    destruido = true
    partes.each do |parte_navio|
      unless parte_navio.destruido?
        destruido = false
        break
      end
    end
    destruido
  end
end

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

class Coordenada
  attr_accessor :x, :y, :orientacao
  
  def initialize(x,y,orientacao=:horizontal)
    @x = x
    @y = y
    @orientacao = orientacao
  end
end

class Quadrante
  attr_accessor :parte_navio, :atacado
  def initialize
    @parte_navio = nil
    @atacado = false
  end
  
  def atacado?
    @atacado
  end
end

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
			header << "#{number_to_alpha(count-1)}   "
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
			header << "#{number_to_alpha(count-1)}   "
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
  
  def atacar(x,y)
    quadrante = @grade[x][alpha_to_number(y)]
    quadrante.atacado = true
		mensagem = nil
		if quadrante.parte_navio.nil?
			mensagem = "Nenhum navio foi atingido durante o ataque!\n"
		else
			quadrante.parte_navio.destruido = true
			mensagem = "Um navio inimigo foi atingido durante o ataque!\n"
			navio = quadrante.parte_navio.navio
			if navio.destruido?
				mensagem << "O navio #{navio.nome} foi destruido!\n"
			end
		end
		mensagem
  end
end

class FabricaGrade
  def self.criar_grade(x,y)
    grade = Array.new x
    grade.each_index do |x_index|
      grade[x_index] = Array.new y
      grade.each_index do |y_index|
        grade[x_index][y_index] = Quadrante.new
      end
    end
    return grade
  end
end

class Jogador
  attr_accessor :nome, :campo, :navios
  def initialize(nome)
    @nome = nome
    grade = FabricaGrade.criar_grade(10,10)
    @campo = Campo.new(grade)
		@navios = Array.new
  end

	def imprimir_campo
		@campo.imprimir
	end
	
	def imprimir_campo_rival
		@campo.imprimir_rival
	end

	def perdeu?
		perdeu = true
		@navios.each do |navio|
			unless navio.destruido?
				perdeu = false
				break
			end
		end
		perdeu
	end
end

class Partida
  attr_accessor :jogador1, :jogador2, :ativo
  
  def initialize
    @jogadores = Hash.new
		@ativo = true
  end
  
  def entrar(nome, navios, coordenadas)
    jogador = Jogador.new nome
    if @jogador1.nil?
      @jogador1 = jogador
    elsif @jogador2.nil?
      @jogador2 = jogador
    else
      raise "Apenas dois jogadores por partidas"
    end
    campo = jogador.campo
    navios.each_index do |i|
      campo.posicionar_navio navios[i], coordenadas[i]
			jogador.navios << navios[i]
    end
  end
  
  def jogador_rival(nome)
    jogador = nil
    if @jogador1.nome.eql? nome
      jogador = @jogador2
    elsif @jogador2.nome.eql? nome
      jogador = @jogador1
    else
      raise "Jogador invalido"
    end
    jogador
  end
  
  def jogador(nome)
    jogador = nil
    if @jogador1.nome.eql? nome
      jogador = @jogador1
    elsif @jogador2.nome.eql? nome
      jogador = @jogador2
    else
      raise "Jogador invalido"
    end
    jogador
  end
  
  def atacar(nome,x,y)
		mensagem
		if @ativo
			campo = jogador_rival(nome).campo
			mensagem = campo.atacar(x,y)
			mensagem << verificar_partida(nome)
		else
		  mensagem = "O jogo acabou!\n"
			mensagem << verificar_partida(nome)
		end
		mensagem
  end

	def imprimir_campos(nome)
		saida = "Seu campo: \n"
		saida << jogador(nome).imprimir_campo
		saida << "Campo rival: \n"
		saida << jogador_rival(nome).imprimir_campo_rival
	end

	def verificar_partida(nome)
		mensagem = ""
		if jogador(nome).perdeu?
			mensagem = "Voce perdeu!\n"
			@ativo = false
		elsif jogador_rival(nome).perdeu?
			mensagem = "Voce venceu!\n"
			@ativo = false
		end
		mensagem
	end
end

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
