use bdEscola

	-- 1 --
	create procedure spInsereAlunoCpf @nomeAluno varchar(35), @dataNasc date, @rgAluno varchar(15), @cpfAluno varchar(15)
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
	exec spInsereAluno 'Clodomito', '1975/03/10', '10.202.201-3', '705.495.565-67', 'São Paulo', 23, 'R. Curso', '21351-690', 'Jd. Course', null

	-- 2 --
	alter procedure spMatriculaAluno @nomeAluno varchar(35), @nomeCurso varchar(20)
	as
	begin
		if exists(select nomeAluno from tbAluno where nomeAluno like @nomeAluno) and exists(select nomeCurso from tbCurso where nomeCurso like @nomeCurso)
			begin
				insert into tbMatricula(codAluno, codTurma, dataMatricula)
				values((select codAluno from tbAluno where nomeAluno like @nomeAluno)
				,(select max(codTurma) from tbCurso inner join tbTurma on tbTurma.codCurso = tbCurso.codCurso where nomeCurso like @nomeCurso), GETDATE())
			end
		else begin print('Aluno ou curso não encontrados!') end
	end
	exec spMatriculaAluno 'Maria da Gloria', 'Inglês'
