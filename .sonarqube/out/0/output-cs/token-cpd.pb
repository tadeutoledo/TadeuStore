Ñ
gC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\EventBus\AutorizarPagamentoIntegrationEvent.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
EventBus $
{ 
public 

class .
"AutorizarPagamentoIntegrationEvent 3
:4 5
IntegrationEvent6 F
{ 
public .
"AutorizarPagamentoIntegrationEvent 1
(1 2
Guid2 6
idAutorizacao7 D
)D E
{ 	
IdTransacao		 
=		 
idAutorizacao		 '
;		' (
}

 	
[ 	
JsonProperty	 
] 
public 
Guid 
IdTransacao 
{  !
get" %
;% &
private' .
init/ 3
;3 4
}5 6
} 
} °
NC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\EventBus\IEventBus.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
EventBus $
{ 
public 

	interface 
	IEventBus 
{ 
void 
Publish 
( 
IntegrationEvent %
@event& ,
), -
;- .
void		 
	Subscribe		 
<		 
TRequest		 
,		  
	TResponse		! *
>		* +
(		+ ,
)		, -
where

 
TRequest

 
:

 
IntegrationEvent

 -
where 
	TResponse 
: 
ResponseMessage -
;- .
} 
} ›
]C:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\EventBus\IIntegrationEventHandler.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
EventBus $
{ 
public		 

	interface		 $
IIntegrationEventHandler		 .
{

 
} 
} å
UC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\EventBus\IntegrationEvent.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
EventBus $
{ 
public 

class 
IntegrationEvent !
:" #$
IIntegrationEventHandler$ <
{ 
public 
IntegrationEvent 
(  
)  !
{		 	
Id

 
=

 
Guid

 
.

 
NewGuid

 
(

 
)

 
;

  
CreationDate 
= 
DateTime #
.# $
UtcNow$ *
;* +
} 	
public 
IntegrationEvent 
(  
Guid  $
id% '
,' (
DateTime) 1

createDate2 <
)< =
{ 	
Id 
= 
id 
; 
CreationDate 
= 

createDate %
;% &
} 	
[ 	
JsonProperty	 
] 
public 
Guid 
Id 
{ 
get 
; 
private %
init& *
;* +
}, -
[ 	
JsonProperty	 
] 
public 
DateTime 
CreationDate $
{% &
get' *
;* +
private, 3
init4 8
;8 9
}: ;
} 
} ê
cC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\FluentValidation\CartaoCreditoValidator.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
FluentValidation ,
{ 
public 

class "
CartaoCreditoValidator '
:( )
AbstractValidator* ;
<; <,
 CartaoCreditoRequisicaoViewModel< \
>\ ]
{ 
public "
CartaoCreditoValidator %
(% &
)& '
{		 	
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
NomeImpresso

 '
)

' (
. 
NotNull 
( 
) 
. 
WithMessage "
(" #
$str# N
)N O
. 
NotEmpty 
( 
) 
. 
WithMessage #
(# $
$str$ R
)R S
. 
MaximumLength 
( 
$num 
) 
.  
WithMessage  +
(+ ,
$str, s
)s t
;t u
RuleFor 
( 
x 
=> 
x 
. 
Bandeira #
)# $
. 
IsInEnum 
( 
) 
. 
WithMessage '
(' (
$str( O
)O P
;P Q
RuleFor 
( 
x 
=> 
x 
. 
DataExpiracao (
)( )
. 
MinimumLength 
( 
$num  
)  !
.! "
WithMessage" -
(- .
$str. g
)g h
. 
MaximumLength 
( 
$num  
)  !
.! "
WithMessage" -
(- .
$str. g
)g h
. 
Must 
(  
ValidarDataExpiracao *
)* +
.+ ,
WithMessage, 7
(7 8
$str8 q
)q r
;r s
RuleFor 
( 
x 
=> 
x 
. 
NumeroCartao '
)' (
. 

CreditCard 
( 
) 
. 
WithMessage )
() *
$str* Q
)Q R
;R S
RuleFor 
( 
x 
=> 
x 
. 
CodigoSeguranca *
)* +
. 
NotNull 
( 
) 
. 
WithMessage &
(& '
$str' R
)R S
. 
GreaterThan 
( 
$num 
) 
.  
WithMessage  +
(+ ,
$str, Z
)Z [
;[ \
} 	
private 
bool  
ValidarDataExpiracao )
() *
string* 0
dataExp1 8
)8 9
{   	
string!! 
data!! 
=!! 
string!!  
.!!  !
Concat!!! '
(!!' (
$str!!( -
,!!- .
dataExp!!/ 6
)!!6 7
;!!7 8
return## 
DateTime## 
.## 
TryParse## $
(##$ %
data##% )
,##) *
out##+ .
_##/ 0
)##0 1
;##1 2
}$$ 	
}&& 
}'' ﬁ+
]C:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\FluentValidation\UsuarioValidator.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
FluentValidation ,
{ 
public 

class 
UsuarioValidator !
:" #
AbstractValidator$ 5
<5 6/
#CadastrarUsuarioRequisicaoViewModel6 Y
>Y Z
{ 
public 
UsuarioValidator 
(  
)  !
{		 	
RuleFor

 
(

 
x

 
=>

 
x

 
.

 
Nome

 
)

  
. 
NotNull 
( 
) 
. 
WithMessage &
(& '
$str' R
)R S
. 
NotEmpty 
( 
) 
. 
WithMessage '
(' (
$str( V
)V W
. 
MaximumLength 
( 
$num "
)" #
.# $
WithMessage$ /
(/ 0
$str0 w
)w x
;x y
RuleFor 
( 
x 
=> 
x 
. 
Email  
)  !
. 
EmailAddress 
( 
) 
.  
WithMessage  +
(+ ,
$str, S
)S T
;T U
RuleFor 
( 
x 
=> 
x 
. 
Sexo 
)  
. 
IsInEnum 
( 
) 
. 
WithMessage '
(' (
$str( O
)O P
;P Q
RuleFor 
( 
x 
=> 
x 
. 
Cpf 
) 
. 
NotNull 
( 
) 
. 
WithMessage &
(& '
$str' R
)R S
. 
NotEmpty 
( 
) 
. 
WithMessage '
(' (
$str( V
)V W
. 
MaximumLength 
( 
$num !
)! "
." #
WithMessage# .
(. /
$str/ v
)v w
. 
MinimumLength 
( 
$num !
)! "
." #
WithMessage# .
(. /
$str/ v
)v w
;w x
RuleFor 
( 
x 
=> 
x 
. 
Senha  
)  !
. 
NotEmpty 
( 
) 
. 
WithMessage '
(' (
$str( V
)V W
. 
MinimumLength 
( 
$num  
)  !
.! "
WithMessage" -
(- .
$str. u
)u v
. 
MaximumLength 
( 
$num !
)! "
." #
WithMessage# .
(. /
$str/ v
)v w
. 
Matches 
( 
$str "
)" #
.# $
WithMessage$ /
(/ 0
$str0 k
)k l
.   
Matches   
(   
$str   "
)  " #
.  # $
WithMessage  $ /
(  / 0
$str  0 k
)  k l
.!! 
Matches!! 
(!! 
$str!! "
)!!" #
.!!# $
WithMessage!!$ /
(!!/ 0
$str!!0 ]
)!!] ^
."" 
Matches"" 
("" 
$str"" '
)""' (
.""( )
WithMessage"") 4
(""4 5
$str	""5 Ä
)
""Ä Å
;
""Å Ç
RuleFor$$ 
($$ 
x$$ 
=>$$ 
x$$ 
.$$ 
DataNascimento$$ )
)$$) *
.%% 
Must%% 
(%% 

DataValida%%  
)%%  !
.%%! "
WithMessage%%" -
(%%- .
$str%%. U
)%%U V
;%%V W
RuleFor'' 
('' 
x'' 
=>'' 
x'' 
.'' 
Cpf'' 
)'' 
.(( 
Must(( 
((( 
	CpfValido(( 
)((  
.((  !
WithMessage((! ,
(((, -
$str((- T
)((T U
;((U V
;((W X
}** 	
private,, 
bool,, 
	CpfValido,, 
(,, 
string,, %
cpf,,& )
),,) *
{-- 	
return.. 
String.. 
... 
Join.. 
(.. 
$str.. !
,..! "
cpf..# &
...& '
Where..' ,
(.., -
c..- .
=>../ 1
Char..2 6
...6 7
IsDigit..7 >
(..> ?
c..? @
)..@ A
)..A B
)..B C
...C D
Length..D J
==..K M
$num..N P
;..P Q
}// 	
private11 
bool11 

DataValida11 
(11  
DateTime11  (
date11) -
)11- .
{22 	
return33 
!33 
date33 
.33 
Equals33 
(33  
default33  '
(33' (
DateTime33( 0
)330 1
)331 2
;332 3
}44 	
}55 
}66 ‰
WC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\ICacheConnection.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
{ 
public 

	interface 
ICacheConnection %
:& '
IDistributedCache( 9
{ 
Task 
SetAsync 
< 
T 
> 
( 
string 
key  #
,# $
T% &
value' ,
,, -
TimeSpan. 6
expiry7 =
)= >
;> ?
Task 
< 
T 
> 
GetAsync 
< 
T 
> 
( 
string "
key# &
)& '
;' (
}		 
}

 Ì
hC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Repositorys\IAplicativoRepository.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Repositorys' 2
{ 
public 

	interface !
IAplicativoRepository *
:+ ,
IRepository- 8
<8 9

Aplicativo9 C
>C D
{ 
} 
} ˆ
kC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Repositorys\ICartaoCreditoRepository.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Repositorys' 2
{ 
public 

	interface $
ICartaoCreditoRepository -
:. /
IRepository0 ;
<; <
CartaoCredito< I
>I J
{ 
} 
} ù
^C:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Repositorys\IRepository.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Repositorys' 2
{ 
public 

	interface 
IRepository  
<  !
TEntity! (
>( )
:* +
IDisposable, 7
where8 =
TEntity> E
:F G
EntityH N
{ 
Task 
< 
TEntity 
> 
	Adicionar 
(  
TEntity  '
entity( .
). /
;/ 0
Task		 
<		 
TEntity		 
>		 

ObterPorId		  
(		  !
Guid		! %
id		& (
)		( )
;		) *
Task

 
<

 
List

 
<

 
TEntity

 
>

 
>

 

ObterTodos

 &
(

& '
)

' (
;

( )
Task 
	Atualizar 
( 
TEntity 
entity %
)% &
;& '
Task 
Remover 
( 
Guid 
id 
) 
; 
Task 
< 
IEnumerable 
< 
TEntity  
>  !
>! "
Obter# (
(( )

Expression) 3
<3 4
Func4 8
<8 9
TEntity9 @
,@ A
boolB F
>F G
>G H
	expressaoI R
)R S
;S T
} 
} Í
gC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Repositorys\ITransacaoRepository.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Repositorys' 2
{ 
public 

	interface  
ITransacaoRepository )
:* +
IRepository, 7
<7 8
	Transacao8 A
>A B
{ 
} 
} ‰
eC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Repositorys\IUsuarioRepository.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Repositorys' 2
{ 
public 

	interface 
IUsuarioRepository '
:( )
IRepository* 5
<5 6
Usuario6 =
>= >
{ 
} 
}		 ç
bC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Services\IAplicativoService.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Services' /
{ 
public 

	interface 
IAplicativoService '
{ 
Task 
< 
IEnumerable 
< 

Aplicativo #
># $
>$ %

ObterTodos& 0
(0 1
)1 2
;2 3
Task 
< 
	Transacao 
> 
Comprar 
(  
Guid  $
id% '
,' (
CartaoCredito) 6
cartao7 =
,= >
bool? C
salvarCartaoD P
=Q R
falseS X
)X Y
;Y Z
}		 
}

 ä
_C:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Interfaces\Services\IUsuarioService.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

Interfaces &
.& '
Services' /
{ 
public 

	interface 
IUsuarioService $
{ 
Task 
< -
!CadastrarUsuarioRespostaViewModel .
>. /
	Adicionar0 9
(9 :
Usuario: A
	modelViewB K
)K L
;L M
Task		 
<		 "
LoginRespostaViewModel		 #
>		# $
Login		% *
(		* +
Usuario		+ 2
usuario		3 :
)		: ;
;		; <
}

 
} –
MC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Aplicativo.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

class 

Aplicativo 
: 
Entity $
{ 
public 
string 
Nome 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Empresa 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
	Categoria 
{  !
get" %
;% &
set' *
;* +
}, -
public 
DateTime 
DataPublicacao &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
}		 
}

 ñ
PC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\CartaoCredito.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

class 
CartaoCredito 
:  
FormaPagamento! /
{ 
public 
Guid 
	UsuarioId 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Numero 
{ 
get "
;" #
set$ '
;' (
}) *
public		 
string		 
NomeImpresso		 "
{		# $
get		% (
;		( )
set		* -
;		- .
}		/ 0
public

 
TipoBandeiraCartao

 !
Bandeira

" *
{

+ ,
get

- 0
;

0 1
set

2 5
;

5 6
}

7 8
public 
string 
DataExpiracao #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
int 
CodigoSeguranca "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
Usuario 
Usuario 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
override 
bool 
Validar $
($ %
)% &
{ 	
if 
( 
Numero 
== 
null 
) 
{ 
return 
false 
; 
} 
Numero 
= 
Numero 
. 
Replace #
(# $
$str$ '
,' (
$str) +
)+ ,
., -
Replace- 4
(4 5
$str5 8
,8 9
$str: <
)< =
;= >
int 
checksum 
= 
$num 
; 
bool 
	evenDigit 
= 
false "
;" #
foreach 
( 
char 
digit 
in  "
Numero# )
.) *
Reverse* 1
(1 2
)2 3
)3 4
{ 
if 
( 
digit 
< 
$char 
||  "
digit# (
>) *
$char+ .
). /
{ 
return 
false  
;  !
} 
int!! 

digitValue!! 
=!!  
(!!! "
digit!!" '
-!!( )
$char!!* -
)!!- .
*!!/ 0
(!!1 2
	evenDigit!!2 ;
?!!< =
$num!!> ?
:!!@ A
$num!!B C
)!!C D
;!!D E
	evenDigit"" 
="" 
!"" 
	evenDigit"" &
;""& '
while$$ 
($$ 

digitValue$$ !
>$$" #
$num$$$ %
)$$% &
{%% 
checksum&& 
+=&& 

digitValue&&  *
%&&+ ,
$num&&- /
;&&/ 0

digitValue'' 
/='' !
$num''" $
;''$ %
}(( 
})) 
return++ 
(++ 
checksum++ 
%++ 
$num++ !
)++! "
==++# %
$num++& '
;++' (
},, 	
}-- 
}// Æ
IC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Entity.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

abstract 
class 
Entity  
{ 
public 
Entity 
( 
) 
{ 	
Id 
= 
new 
Guid 
( 
) 
; 
} 	
public

 
Guid

 
Id

 
{

 
get

 
;

 
set

  
;

  !
}

" #
} 
} ò
WC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Enums\BandeiraCartao.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
." #
Enums# (
{ 
public 

enum 
TipoBandeiraCartao "
{ 

Mastercard 
, 
Visa 
, 
Elo 
, 
American_Express 
, 
	Hipercard		 
}

 
} ∆
aC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Enums\TipoAutorizacaoTransacao.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
." #
Enums# (
{ 
public 

enum $
TipoAutorizacaoTransacao (
{ 
EmProcessamento 
= 
$num 
, 
Aprovado 
= 
$num 
, 
Recusado 
= 
$num 
} 
}		 ⁄
QC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Enums\TipoSexo.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
." #
Enums# (
{ 
public 

enum 
TipoSexo 
{ 
	Masculino 
= 
$num 
, 
Feminimo 
= 
$num 
} 
} ö
OC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\ErroDetalhes.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

class 
ErroDetalhes 
{ 
public 
int 
codigo 
{ 
get 
;  
set! $
;$ %
}& '
public 
string 
[ 
] 
? 
erros 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ¯
QC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\FormaPagamento.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

abstract 
class 
FormaPagamento (
:) *
Entity+ 1
{ 
public 
abstract 
bool 
Validar $
($ %
)% &
;& '
} 
} Ù
RC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\ResponseMessage.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

class 
ResponseMessage  
{ 
public		 
ValidationResult		 
ValidationResult		  0
{		1 2
get		3 6
;		6 7
set		8 ;
;		; <
}		= >
public 
ResponseMessage 
( 
ValidationResult /
validationResult0 @
)@ A
{ 	
ValidationResult 
= 
validationResult /
;/ 0
} 	
} 
} ∫
LC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Transacao.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

class 
	Transacao 
: 
Entity #
{ 
public 
Guid 
	UsuarioId 
{ 
get  #
;# $
set% (
;( )
}* +
public 
Usuario 
? 
Usuario 
{  !
get" %
;% &
set' *
;* +
}, -
public 
Guid 
AplicativoId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 

Aplicativo 
? 

Aplicativo %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public		 
Guid		 
?		 
CartaoCreditoId		 $
{		% &
get		' *
;		* +
set		, /
;		/ 0
}		1 2
public

 
CartaoCredito

 
?

 
CartaoCredito

 +
{

, -
get

. 1
;

1 2
set

3 6
;

6 7
}

8 9
public 
int 
StatusAutorizacao $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 
decimal 
	ValorPago  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
DateTime 
DataHoraCompra &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
} 
} ê
JC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\Models\Usuario.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 
Models "
{ 
public 

class 
Usuario 
: 
Entity "
{ 
public 
string 
Nome 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
Senha		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
public

 
string

 
Cpf

 
{

 
get

 
;

  
set

! $
;

$ %
}

& '
public 
DateTime 
DataNascimento &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 
TipoSexo 
Sexo 
{ 
get "
;" #
set$ '
;' (
}) *
public 
string 
Endereco 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Complemento !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
IEnumerable 
< 
CartaoCredito (
>( )
CartoesCredito* 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
} 
} Î
uC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\ViewModels\Requisicao\CadastrarUsuarioRequisicaoViewModel.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

ViewModels &
.& '

Requisicao' 1
{ 
public 

class /
#CadastrarUsuarioRequisicaoViewModel 4
{ 
[ 	
Required	 
] 
public		 
string		 
Nome		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
[

 	
Required

	 
]

 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
] 
public 
string 
Senha 
{ 
get !
;! "
set# &
;& '
}( )
[ 	
Required	 
] 
public 
string 
Cpf 
{ 
get 
;  
set! $
;$ %
}& '
[ 	
Required	 
] 
public 
DateTime 
DataNascimento &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	
Required	 
] 
public 
TipoSexo 
Sexo 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	
Required	 
] 
public 
string 
Endereco 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Complemento !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} ‡

rC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\ViewModels\Requisicao\CartaoCreditoRequisicaoViewModel.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

ViewModels &
.& '

Requisicao' 1
{ 
public 

class ,
 CartaoCreditoRequisicaoViewModel 1
{ 
public 
string 
NumeroCartao "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
string 
NomeImpresso "
{# $
get% (
;( )
set* -
;- .
}/ 0
public		 
TipoBandeiraCartao		 !
Bandeira		" *
{		+ ,
get		- 0
;		0 1
set		2 5
;		5 6
}		7 8
public

 
string

 
DataExpiracao

 #
{

$ %
get

& )
;

) *
set

+ .
;

. /
}

0 1
public 
int 
CodigoSeguranca "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
bool 
Salvar 
{ 
get  
;  !
set" %
;% &
}' (
} 
} ¡
jC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\ViewModels\Requisicao\LoginRequisicaoViewModel.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

ViewModels &
.& '

Requisicao' 1
{ 
public 

class $
LoginRequisicaoViewModel )
{ 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
Senha		 
{		 
get		 !
;		! "
set		# &
;		& '
}		( )
}

 
} ﬁ
qC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\ViewModels\Resposta\CadastrarUsuarioRespostaViewModel.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

ViewModels &
.& '
Resposta' /
{ 
public 

class -
!CadastrarUsuarioRespostaViewModel 2
{ 
public 
string 
Nome 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
Cpf		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
public

 
DateTime

 
DataNascimento

 &
{

' (
get

) ,
;

, -
set

. 1
;

1 2
}

3 4
public 
TipoSexo 
Sexo 
{ 
get "
;" #
set$ '
;' (
}) *
public 
string 
Endereco 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Complemento !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} Í
rC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\ViewModels\Resposta\ComprarAplicativoRespostaViewModel.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

ViewModels &
.& '
Resposta' /
{ 
public 

class .
"ComprarAplicativoRespostaViewModel 3
{ 
public 
Guid 
Id 
{ 
get 
; 
set !
;! "
}# $
public $
TipoAutorizacaoTransacao '
StatusAutorizacao( 9
{: ;
get< ?
;? @
setA D
;D E
}F G
}		 
}

 π
fC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Domain\ViewModels\Resposta\LoginRespostaViewModel.cs
	namespace 	

TadeuStore
 
. 
Domain 
. 

ViewModels &
.& '
Resposta' /
{ 
public 

class "
LoginRespostaViewModel '
{ 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Token 
{ 
get !
;! "
set# &
;& '
}( )
} 
} 