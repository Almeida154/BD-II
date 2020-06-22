use bdEscola
	
	-- a --
	select nomeCurso as 'Curso', valorCurso as 'Preço' from tbCurso
		where valorCurso not in (select valorCurso from tbCurso
			where valorCurso > (select avg(valorCurso) from tbCurso))

	-- b --
	select nomeAluno as 'Nome', rgAluno as 'Rg', FORMAT(dataNascAluno, 'dd/MM/yyyy') as 'Data de Nascimento' from tbAluno
		where dataNascAluno = (select max(dataNascAluno) from tbAluno)

	-- c --
	select nomeAluno as 'Nome' from tbAluno
		where dataNascAluno = (select min(dataNascAluno) from tbAluno)

	-- d --
	select nomeCurso as 'Curso', valorCurso as 'Preço' from tbCurso
		where valorCurso = (select max(valorCurso) from tbCurso)

	-- e --
	select nomeAluno as 'Nome', nomeCurso as 'Curso', FORMAT(dataMatricula, 'dd/MM/yyyy') as 'Data de Matrícula' from tbAluno
		inner join tbMatricula on tbMatricula.codAluno = tbAluno.codAluno
			inner join tbTurma on tbMatricula.codTurma = tbTurma.codTurma
				inner join tbCurso on tbTurma.codCurso = tbCurso.codCurso
					where dataMatricula = (select max(dataMatricula) from tbMatricula)

	-- f --
	select nomeAluno as 'Nome', FORMAT(dataMatricula, 'dd/MM/yyyy') as 'Data de Matrícula' from tbAluno
		inner join tbMatricula on tbMatricula.codAluno = tbAluno.codAluno
			inner join tbTurma on tbMatricula.codTurma = tbTurma.codTurma
				inner join tbCurso on tbTurma.codCurso = tbCurso.codCurso
					where dataMatricula = (select min(dataMatricula) from tbMatricula)

	-- g --
	select nomeAluno as 'Nome', rgAluno as 'Rg', FORMAT(dataNascAluno, 'dd/MM/yyyy') as 'Data de Nascimento' from tbAluno
		inner join tbMatricula on tbMatricula.codAluno = tbAluno.codAluno
			inner join tbTurma on tbMatricula.codTurma = tbTurma.codTurma
				inner join tbCurso on tbTurma.codCurso = tbCurso.codCurso
					where nomeCurso = (select nomeCurso from tbCurso
						where nomeCurso like 'Inglês')