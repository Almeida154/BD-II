use bdEscola


	-- 1 --

	create function fcEnrollmentDay(@date date) returns varchar(30) as
	begin
		declare @weekDay varchar(40)
		declare @day int set @day = DATEPART(dw, @date)
		set @weekDay = (
				case @day
					when 1 then 'Domingo'
					when 2 then 'Segunda-Feira'
					when 3 then 'Terça-Feira'
					when 4 then 'Quarta-Feira'
					when 5 then 'Quinta-Feira'
					when 6 then 'Sexta-Feira'
					when 7 then 'Sábado'
					else 'Aluno não encontrado!'
				end
			)
		return @weekDay
	end

	create function fcGetEnrollmentDate(@codAluno smallint) returns date as
	begin
		declare @date date
		if exists(select codAluno from tbAluno where codAluno = @codAluno)
			begin set @date = (select max(dataMatricula) from tbMatricula where codAluno = @codAluno) end
		else begin set @date = (select ERROR_MESSAGE() as ErrorMessage) end
		return @date
	end

	select DayOfTheWeek = dbo.fcEnrollmentDay(dbo.fcGetEnrollmentDate(1)) -- Informando com base em um cod
	select DayOfTheWeek = dbo.fcEnrollmentDay(GETDATE()) -- Informando uma data diretamente


	-- 2 --

	create function fcCourseLoad(@courseName varchar(8)) returns varchar(20) as
	begin
		declare @courseLoad int
		declare @opc varchar(20)
		set @courseLoad = (select cargaHorariaCurso from tbCurso where nomeCurso like @courseName)
		set @opc = (
				case 
					when @courseLoad > 1000 then 'Curso extenso'
					when @courseLoad < 1001 then 'Curso rápido'
					else 'Curso não encontrado!'
				end
			)
		return @opc
	end

	select CourseLoad = dbo.fcCourseLoad('Inglês')
	select CourseLoad = dbo.fcCourseLoad('asdaskdjbaksjfd')


	-- 3 --

	create function fcCoursePrice(@courseName varchar(8)) returns varchar(20) as
	begin
		declare @coursePrice smallmoney
		declare @opc varchar(20)
		set @coursePrice = (select valorCurso from tbCurso where nomeCurso like @courseName)
		set @opc = (
				case 
					when @coursePrice > 400 then 'Curso caro'
					when @coursePrice < 401 then 'Curso barato'
					else 'Curso não encontrado!'
				end
			)
		return @opc
	end

	select CourseLoad = dbo.fcCoursePrice('Alemão')
	select CourseLoad = dbo.fcCoursePrice('asdaskdjbaksjfd')
	

	-- 4 --

	create function fcConvertEnrollmentDate(@date date) returns varchar(10) as
	begin
		declare @newDateFormat varchar(10) set @newDateFormat = CONVERT(varchar, @date, 103)
		return @newDateFormat
	end

	select EnrollmentDate = dbo.fcConvertEnrollmentDate(dbo.fcGetEnrollmentDate(1)) -- Informando com base em um cod
	select EnrollmentDate = dbo.fcConvertEnrollmentDate(GETDATE()) -- Informando uma data diretamente