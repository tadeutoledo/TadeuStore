…K
OC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Services\AplicativoService.cs
	namespace

 	

TadeuStore


 
.

 
Services

 
{ 
public 

class 
AplicativoService "
:# $
IAplicativoService% 7
{ 
private 
readonly  
IHttpContextAccessor - 
_httpContextAccessor. B
;B C
private 
readonly 
IUsuarioRepository +
_usuarioRepository, >
;> ?
private 
readonly !
IAplicativoRepository .!
_aplicativoRepository/ D
;D E
private 
readonly $
ICartaoCreditoRepository 1$
_cartaoCreditoRepository2 J
;J K
private 
readonly  
ITransacaoRepository - 
_transacaoRepository. B
;B C
private 
readonly 
	IEventBus "
_bus# '
;' (
private 
readonly 
ICacheConnection )
_cache* 0
;0 1
public 
AplicativoService  
(  ! 
IHttpContextAccessor  
httpContextAccessor! 4
,4 5
IUsuarioRepository 
usuarioRepository 0
,0 1!
IAplicativoRepository ! 
aplicativoRepository" 6
,6 7$
ICartaoCreditoRepository $#
cartaoCreditoRepository% <
,< = 
ITransacaoRepository  
transacaoRepository! 4
,4 5
	IEventBus 
bus 
, 
ICacheConnection 
cache "
)" #
{ 	 
_httpContextAccessor  
=! "
httpContextAccessor# 6
;6 7
_usuarioRepository   
=    
usuarioRepository  ! 2
;  2 3!
_aplicativoRepository!! !
=!!" # 
aplicativoRepository!!$ 8
;!!8 9$
_cartaoCreditoRepository"" $
=""% &#
cartaoCreditoRepository""' >
;""> ? 
_transacaoRepository##  
=##! "
transacaoRepository### 6
;##6 7
_bus$$ 
=$$ 
bus$$ 
;$$ 
_cache%% 
=%% 
cache%% 
;%% 
}&& 	
public(( 
async(( 
Task(( 
<(( 
IEnumerable(( %
<((% &

Aplicativo((& 0
>((0 1
>((1 2

ObterTodos((3 =
(((= >
)((> ?
{)) 	
var** 

chaveCache** 
=** 
$str** *
;*** +
var++ 
aplicativos++ 
=++ 
await++ #
_cache++$ *
.++* +
GetAsync+++ 3
<++3 4
IEnumerable++4 ?
<++? @

Aplicativo++@ J
>++J K
>++K L
(++L M

chaveCache++M W
)++W X
;++X Y
if-- 
(-- 
aplicativos-- 
?-- 
.-- 
Any--  
(--  !
)--! "
??--# %
false--& +
)--+ ,
return.. 
aplicativos.. "
;.." #
aplicativos00 
=00 
await00 !
_aplicativoRepository00  5
.005 6

ObterTodos006 @
(00@ A
)00A B
;00B C
await22 
_cache22 
.22 
SetAsync22 !
(22! "

chaveCache22" ,
,22, -
aplicativos22. 9
,229 :
TimeSpan22; C
.22C D
FromMinutes22D O
(22O P
$num22P Q
)22Q R
)22R S
;22S T
return44 
aplicativos44 
;44 
}55 	
public77 
async77 
Task77 
<77 
	Transacao77 #
>77# $
Comprar77% ,
(77, -
Guid77- 1
id772 4
,774 5
CartaoCredito776 C
cartao77D J
,77J K
bool77L P
salvarCartao77Q ]
=77^ _
false77` e
)77e f
{88 	
if99 
(99 
!99 
cartao99 
.99 
Validar99 
(99  
)99  !
)99! "
throw:: 
new:: 
ArgumentException:: +
(::+ ,
$str::, I
)::I J
;::J K
var<< 
	idUsuario<< 
=<<  
_httpContextAccessor<< 0
.== 
HttpContext== 
.>> 
User>> 
.?? 
Claims?? 
.@@ 
Where@@ 
(@@ 
x@@ 
=>@@ 
x@@ 
.@@ 
Type@@ "
==@@# %

ClaimTypes@@& 0
.@@0 1
NameIdentifier@@1 ?
)@@? @
.AA 
FirstOrDefaultAA 
(AA  
)AA  !
?AA! "
.BB 
ValueBB 
;BB 
GuidDD 
idUsuarioTratadoDD !
=DD" #
GuidDD$ (
.DD( )
EmptyDD) .
;DD. /
ifFF 
(FF 
!FF 
GuidFF 
.FF 
TryParseFF 
(FF 
	idUsuarioFF (
,FF( )
outFF* -
idUsuarioTratadoFF. >
)FF> ?
)FF? @
throwGG 
newGG 
ArgumentExceptionGG +
(GG+ ,
$"GG, .
$strGG. K
"GGK L
)GGL M
;GGM N
varII 
usuarioII 
=II 
awaitII 
_usuarioRepositoryII  2
.II2 3

ObterPorIdII3 =
(II= >
idUsuarioTratadoII> N
)IIN O
;IIO P
ifKK 
(KK 
usuarioKK 
==KK 
nullKK 
)KK  
throwLL 
newLL 
ArgumentExceptionLL +
(LL+ ,
$"LL, .
$strLL. 9
{LL9 :
	idUsuarioLL: C
?LLC D
.LLD E
ToStringLLE M
(LLM N
)LLN O
}LLO P
$strLLP d
"LLd e
)LLe f
;LLf g
varNN 

aplicativoNN 
=NN 
awaitNN "!
_aplicativoRepositoryNN# 8
.NN8 9

ObterPorIdNN9 C
(NNC D
idNND F
)NNF G
;NNG H
ifPP 
(PP 

aplicativoPP 
==PP 
nullPP "
)PP" #
throwQQ 
newQQ 
ArgumentExceptionQQ +
(QQ+ ,
$"QQ, .
$strQQ. <
{QQ< =
idQQ= ?
}QQ? @
$strQQ@ T
"QQT U
)QQU V
;QQV W
cartaoSS 
=SS 
usuarioSS 
.SS 
CartoesCreditoSS +
?SS+ ,
.SS, -
WhereSS- 2
(SS2 3
xSS3 4
=>SS5 7
xSS8 9
.SS9 :
NumeroSS: @
==SSA C
cartaoSSD J
.SSJ K
NumeroSSK Q
&&SSR T
xSSU V
.SSV W
	UsuarioIdSSW `
==SSa c
usuarioSSd k
.SSk l
IdSSl n
)SSn o
?SSo p
.SSp q
FirstOrDefaultSSq 
(	SS Ä
)
SSÄ Å
??
SSÇ Ñ
cartao
SSÖ ã
;
SSã å
ifUU 
(UU 
salvarCartaoUU 
&&UU 
cartaoUU  &
?UU& '
.UU' (
IdUU( *
==UU+ -
GuidUU. 2
.UU2 3
EmptyUU3 8
)UU8 9
{VV 
cartaoWW 
.WW 
	UsuarioIdWW  
=WW! "
usuarioWW# *
.WW* +
IdWW+ -
;WW- .
cartaoXX 
=XX 
awaitXX $
_cartaoCreditoRepositoryXX 7
.XX7 8
	AdicionarXX8 A
(XXA B
cartaoXXB H
)XXH I
;XXI J
}YY 
var[[ 
	transacao[[ 
=[[ 
new[[ 
	Transacao[[  )
([[) *
)[[* +
{\\ 
AplicativoId]] 
=]] 
id]] !
,]]! "
	UsuarioId^^ 
=^^ 
usuario^^ #
.^^# $
Id^^$ &
,^^& '
CartaoCreditoId__ 
=__  !
cartao__" (
?__( )
.__) *
Id__* ,
==__- /
Guid__0 4
.__4 5
Empty__5 :
?__; <
null__= A
:__B C
cartao__D J
?__J K
.__K L
Id__L N
,__N O
	ValorPago`` 
=`` 
(`` 
decimal`` $
)``$ %
new``% (
Random``) /
(``/ 0
)``0 1
.``1 2

NextDouble``2 <
(``< =
)``= >
,``> ?
DataHoraCompraaa 
=aa  
DateTimeaa! )
.aa) *
Nowaa* -
,aa- .
StatusAutorizacaobb !
=bb" #
(bb$ %
intbb% (
)bb( )$
TipoAutorizacaoTransacaobb) A
.bbA B
EmProcessamentobbB Q
}cc 
;cc 
	transacaoee 
=ee 
awaitee  
_transacaoRepositoryee 2
.ee2 3
	Adicionaree3 <
(ee< =
	transacaoee= F
)eeF G
;eeG H
_busgg 
.gg 
Publishgg 
(gg 
newgg .
"AutorizarPagamentoIntegrationEventgg ?
(gg? @
	transacaogg@ I
.ggI J
IdggJ L
)ggL M
)ggM N
;ggN O
returnii 
	transacaoii 
;ii 
}jj 	
}kk 
}ll Ó/
LC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Services\UsuarioService.cs
	namespace 	

TadeuStore
 
. 
Services 
{ 
public 

class 
UsuarioService 
:  !
IUsuarioService" 1
{ 
private 
readonly 
IUsuarioRepository +
_usuarioRepository, >
;> ?
private 
readonly 
IMapper  
_mapper! (
;( )
public 
UsuarioService 
( 
IMapper 
mapper 
, 
IUsuarioRepository 
usuarioRepository 0
)0 1
{ 	
_mapper 
= 
mapper 
; 
_usuarioRepository 
=  
usuarioRepository! 2
;2 3
} 	
private 
string 

GerarToken !
(! "
Usuario" )
usuario* 1
)1 2
{ 	
var 
keySettings 
= 
$str D
;D E
var 
tokenHandler 
= 
new "#
JwtSecurityTokenHandler# :
(: ;
); <
;< =
var 
key 
= 
Encoding 
. 
ASCII $
.$ %
GetBytes% -
(- .
keySettings. 9
)9 :
;: ;
var   
tokenDescriptor   
=    !
new  " %#
SecurityTokenDescriptor  & =
{!! 
Subject"" 
="" 
new"" 
ClaimsIdentity"" ,
("", -
new""- 0
Claim""1 6
[""6 7
]""7 8
{## 
new$$ 
Claim$$ 
($$ 

ClaimTypes$$ (
.$$( )
Email$$) .
,$$. /
usuario$$0 7
.$$7 8
Email$$8 =
.$$= >
ToString$$> F
($$F G
)$$G H
)$$H I
,$$I J
new%% 
Claim%% 
(%% 

ClaimTypes%% (
.%%( )
NameIdentifier%%) 7
,%%7 8
usuario%%9 @
.%%@ A
Id%%A C
.%%C D
ToString%%D L
(%%L M
)%%M N
)%%N O
}&& 
)&& 
,&& 
Expires'' 
='' 
DateTime'' "
.''" #
UtcNow''# )
.'') *
AddHours''* 2
(''2 3
$num''3 4
)''4 5
,''5 6
SigningCredentials(( "
=((# $
new((% (
SigningCredentials(() ;
(((; <
new((< ? 
SymmetricSecurityKey((@ T
(((T U
key((U X
)((X Y
,((Y Z
SecurityAlgorithms(([ m
.((m n 
HmacSha256Signature	((n Å
)
((Å Ç
})) 
;)) 
var** 
token** 
=** 
tokenHandler** $
.**$ %
CreateToken**% 0
(**0 1
tokenDescriptor**1 @
)**@ A
;**A B
return++ 
tokenHandler++ 
.++  

WriteToken++  *
(++* +
token+++ 0
)++0 1
;++1 2
},, 	
public.. 
async.. 
Task.. 
<.. -
!CadastrarUsuarioRespostaViewModel.. ;
>..; <
	Adicionar..= F
(..F G
Usuario..G N
usuario..O V
)..V W
{// 	
var00 
usuarioCadastrado00 !
=00" #
await00$ )
_usuarioRepository00* <
.00< =
Obter00= B
(00B C
x00C D
=>00E G
x00H I
.00I J
Email00J O
==00P R
usuario00S Z
.00Z [
Email00[ `
)00` a
;00a b
if22 
(22 
usuarioCadastrado22 !
.22! "
Any22" %
(22% &
)22& '
)22' (
throw33 
new33 
ArgumentException33 +
(33+ ,
$str33, L
)33L M
;33M N
await55 
_usuarioRepository55 $
.55$ %
	Adicionar55% .
(55. /
usuario55/ 6
)556 7
;557 8
return77 
_mapper77 
.77 
Map77 
<77 -
!CadastrarUsuarioRespostaViewModel77 @
>77@ A
(77A B
usuario77B I
)77I J
;77J K
}88 	
public:: 
async:: 
Task:: 
<:: "
LoginRespostaViewModel:: 0
>::0 1
Login::2 7
(::7 8
Usuario::8 ?
usuario::@ G
)::G H
{;; 	
var<< 
usuarioCadastrado<< !
=<<" #
await<<$ )
_usuarioRepository<<* <
.<<< =
Obter<<= B
(<<B C
x<<C D
=><<E G
x<<H I
.<<I J
Email<<J O
==<<P R
usuario<<S Z
.<<Z [
Email<<[ `
&&<<a c
x<<d e
.<<e f
Senha<<f k
==<<l n
usuario<<o v
.<<v w
Senha<<w |
)<<| }
;<<} ~
if>> 
(>> 
!>> 
usuarioCadastrado>> "
.>>" #
Any>># &
(>>& '
)>>' (
)>>( )
throw?? 
new?? 
ArgumentException?? +
(??+ ,
$str??, H
)??H I
;??I J
varAA 
tokenAA 
=AA 

GerarTokenAA "
(AA" #
usuarioCadastradoAA# 4
.AA4 5
FirstOrDefaultAA5 C
(AAC D
)AAD E
)AAE F
;AAF G
returnCC 
newCC "
LoginRespostaViewModelCC -
(CC- .
)CC. /
{DD 
EmailEE 
=EE 
usuarioEE 
.EE  
EmailEE  %
,EE% &
TokenFF 
=FF 
tokenFF 
}GG 
;GG 
}HH 	
}II 
}JJ 