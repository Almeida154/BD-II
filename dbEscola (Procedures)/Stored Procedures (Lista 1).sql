
	-- 1 --
	create procedure spBuscaAluno @codAluno int
	as
	begin
		if exists (select codAluno from tbAluno where codAluno = @codAluno)
			begin
				select nomeAluno as 'Nome', dataNascAluno as 'Data de nascimento' from tbAluno
				where codAluno = @codAluno
			end
		else begin print('Código inválido!') end
	end
	exec spBuscaAluno 6

	-- 2 --
	create procedure spInsereAluno @nomeAluno varchar(35), @dataNasc date, @rgAluno varchar(15), @cpfAluno varchar(15)
		,@cidadeAluno varchar(15), @numeroAluno int, @logradouroAluno varchar(20), @cepAluno varchar(15), @bairroAluno varchar(15)
		,@complementoAluno varchar(15)
	as
	begin
		if exists(select cpfAluno from tbAluno where cpfAluno like @cpfAluno)
			begin print('Aluno já cadastrado!') end
		else
			begin
				insert into tbAluno(nomeAluno, dataNascAluno, rgAluno, cpfAluno, cidadeAluno, numeroAluno, logradouroAluno, cepAluno
				,bairroAluno, complementoAluno)
				values(@nomeAluno, @dataNasc, @rgAluno, @cpfAluno, @cidadeAluno, @numeroAluno, @logradouroAluno, @cepAluno
				,@bairroAluno, @complementoAluno)
			end
	end
	exec spInsereAluno 'Pato Careca', '1985/03/10', '81.212.121-5', '525.492.585-67', 'São Paulo', 23, 'R. Morumbi', '21351-690', 'Morumbi', null

	-- 3 --
	create procedure spAumentaPreco @nomeCurso varchar(20), @percentual float
	as
	begin
		if exists(select nomeCurso from tbCurso where nomeCurso like @nomeCurso)
			begin
				update tbCurso set valorCurso += (valorCurso * @percentual) / 100 where nomeCurso like @nomeCurso
			end
		else begin print('Curso não encontrado') end
	end
	exec spAumentaPreco 'Alemão', 30

	-- 4 --
	create procedure spExibeTurma @nomeTurma varchar(10)
	as
	begin
		if exists(select descricaoTurma from tbTurma where descricaoTurma like @nomeTurma) 
			begin 
				select * from tbTurma where descricaoTurma like @nomeTurma
			end
		else begin print('Turma não encontrada') end
	end
	exec spExibeTurma '1|A'

	-- 5 --
	create procedure spExibeAlunosTurma @nomeTurma varchar(10)
	as
	begin
		if exists(select descricaoTurma from tbTurma where descricaoTurma like @nomeTurma) 
			begin 
				select nomeAluno as 'Alunos' from tbAluno
					inner join tbMatricula on tbMatricula.codAluno = tbAluno.codAluno
						inner join tbTurma on tbMatricula.codTurma = tbTurma.codTurma
							where tbTurma.descricaoTurma like @nomeTurma
			end
		else begin print('Turma não encontrada') end
	end
	exec spExibeAlunosTurma '1|A'