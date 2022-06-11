©
WC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Configuration\AutomapperConfig.cs
	namespace 	

TadeuStore
 
. 
API 
. 
Configuration &
{ 
public 

class 
AutomapperConfig !
:" #
Profile$ +
{		 
public

 
AutomapperConfig

 
(

  
)

  !
{ 	
	CreateMap 
< /
#CadastrarUsuarioRequisicaoViewModel 9
,9 :
Usuario; B
>B C
(C D
)D E
.E F

ReverseMapF P
(P Q
)Q R
;R S
	CreateMap 
< $
LoginRequisicaoViewModel .
,. /
Usuario0 7
>7 8
(8 9
)9 :
.: ;

ReverseMap; E
(E F
)F G
;G H
	CreateMap 
< -
!CadastrarUsuarioRespostaViewModel 7
,7 8
Usuario9 @
>@ A
(A B
)B C
.C D

ReverseMapD N
(N O
)O P
;P Q
	CreateMap 
< ,
 CartaoCreditoRequisicaoViewModel 6
,6 7
CartaoCredito8 E
>E F
(F G
)G H
. 
	ForMember 
( 
dst 
=> !
dst" %
.% &
Numero& ,
,, -
map. 1
=>2 4
map5 8
.8 9
MapFrom9 @
(@ A
srcA D
=>E G
srcH K
.K L
NumeroCartaoL X
)X Y
)Y Z
. 

ReverseMap 
( 
) 
; 
	CreateMap 
< 
	Transacao 
,  .
"ComprarAplicativoRespostaViewModel! C
>C D
(D E
)E F
. 
	ForMember 
( 
dst 
=> !
dst" %
.% &
Id& (
,( )
map* -
=>. 0
map1 4
.4 5
MapFrom5 <
(< =
src= @
=>A C
srcD G
.G H
IdH J
)J K
)K L
. 
	ForMember 
( 
dst 
=> !
dst" %
.% &
StatusAutorizacao& 7
,7 8
map9 <
=>= ?
map@ C
.C D
MapFromD K
(K L
srcL O
=>P R
srcS V
.V W
StatusAutorizacaoW h
)h i
)i j
. 

ReverseMap 
( 
) 
; 
} 	
} 
} ä
PC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Configuration\JwtConfig.cs
	namespace 	

TadeuStore
 
. 
API 
. 
Configuration &
{ 
public 

static 
class 
	JwtConfig !
{ 
public		 
static		 
IServiceCollection		 (
AddJwtConfig		) 5
(		5 6
this		6 :
IServiceCollection		; M
services		N V
)		V W
{

 	
var 
key 
= 
Encoding 
. 
ASCII $
.$ %
GetBytes% -
(- .
$str. T
)T U
;U V
services 
. 
AddAuthentication &
(& '
x' (
=>) +
{ 
x 
. %
DefaultAuthenticateScheme +
=, -
JwtBearerDefaults. ?
.? @ 
AuthenticationScheme@ T
;T U
x 
. "
DefaultChallengeScheme (
=) *
JwtBearerDefaults+ <
.< = 
AuthenticationScheme= Q
;Q R
} 
) 
. 
AddJwtBearer 
( 
x 
=> 
{ 
x 
.  
RequireHttpsMetadata &
=' (
false) .
;. /
x 
. 
	SaveToken 
= 
true "
;" #
x 
. %
TokenValidationParameters +
=, -
new. 1%
TokenValidationParameters2 K
{ $
ValidateIssuerSigningKey ,
=- .
true/ 3
,3 4
IssuerSigningKey $
=% &
new' * 
SymmetricSecurityKey+ ?
(? @
key@ C
)C D
,D E
ValidateIssuer "
=# $
false% *
,* +
ValidateAudience $
=% &
false' ,
} 
; 
} 
) 
; 
return 
services 
; 
}   	
}!! 
}"" ®:
^C:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Configuration\VersioningSwaggerConfig.cs
	namespace 	

TadeuStore
 
. 
API 
. 
Configuration &
{ 
public		 

static		 
class		 #
VersioningSwaggerConfig		 /
{

 
public 
static 
IServiceCollection (
AddSwaggerConfig) 9
(9 :
this: >
IServiceCollection? Q
servicesR Z
)Z [
{ 	
services 
. 
AddApiVersioning %
(% &
options& -
=>. 0
{ 
options 
. /
#AssumeDefaultVersionWhenUnspecified ;
=< =
true> B
;B C
options 
. 
DefaultApiVersion )
=* +
new, /

ApiVersion0 :
(: ;
$num; <
,< =
$num> ?
)? @
;@ A
options 
. 
ReportApiVersions )
=* +
true, 0
;0 1
} 
) 
; 
services 
. #
AddVersionedApiExplorer ,
(, -
options- 4
=>5 7
{ 
options 
. 
GroupNameFormat '
=( )
$str* 2
;2 3
options 
. %
SubstituteApiVersionInUrl 1
=2 3
true4 8
;8 9
} 
) 
; 
services 
. 
AddSwaggerGen "
(" #
c# $
=>% '
{ 
c 
. !
AddSecurityDefinition '
(' (
$str( 0
,0 1
new2 5!
OpenApiSecurityScheme6 K
(K L
)L M
{ 
Description 
=  !
$str" J
,J K
Name 
= 
$str *
,* +
Scheme   
=   
$str   %
,  % &
BearerFormat!!  
=!!! "
$str!!# (
,!!( )
In"" 
="" 
ParameterLocation"" *
.""* +
Header""+ 1
,""1 2
Type## 
=## 
SecuritySchemeType## -
.##- .
ApiKey##. 4
}$$ 
)$$ 
;$$ 
c&& 
.&& "
AddSecurityRequirement&& (
(&&( )
new&&) ,&
OpenApiSecurityRequirement&&- G
{'' 
{(( 
new)) !
OpenApiSecurityScheme)) 1
{** 
	Reference++ %
=++& '
new++( +
OpenApiReference++, <
{,, 
Type--  $
=--% &
ReferenceType--' 4
.--4 5
SecurityScheme--5 C
,--C D
Id..  "
=..# $
$str..% -
}// 
}00 
,00 
new11 
string11 "
[11" #
]11# $
{11% &
}11& '
}22 
}33 
)33 
;33 
}44 
)44 
;44 
return66 
services66 
;66 
}77 	
public99 
static99 
IApplicationBuilder99 )
UseSwaggerConfig99* :
(99: ;
this99; ?
IApplicationBuilder99@ S
app99T W
,99W X*
IApiVersionDescriptionProvider99Y w
provider	99x €
)
99€ 
{:: 	
app;; 
.;; 

UseSwagger;; 
(;; 
);; 
;;; 
app<< 
.<< 
UseSwaggerUI<< 
(<< 
options== 
=>== 
{>> 
foreach?? 
(?? 
var??  
description??! ,
in??- /
provider??0 8
.??8 9"
ApiVersionDescriptions??9 O
)??O P
{@@ 
optionsAA 
.AA  
SwaggerEndpointAA  /
(AA/ 0
$"AA0 2
$strAA2 ;
{AA; <
descriptionAA< G
.AAG H
	GroupNameAAH Q
}AAQ R
$strAAR _
"AA_ `
,AA` a
descriptionAAb m
.AAm n
	GroupNameAAn w
.AAw x
ToUpperInvariant	AAx ˆ
(
AAˆ ‰
)
AA‰ Š
)
AAŠ ‹
;
AA‹ Œ
}BB 
}CC 
)CC 
;CC 
returnDD 
appDD 
;DD 
}EE 	
}FF 
publicHH 

classHH #
ConfigureSwaggerOptionsHH (
:HH) *
IConfigureOptionsHH+ <
<HH< =
SwaggerGenOptionsHH= N
>HHN O
{II 
readonlyJJ *
IApiVersionDescriptionProviderJJ /
providerJJ0 8
;JJ8 9
publicLL #
ConfigureSwaggerOptionsLL &
(LL& '*
IApiVersionDescriptionProviderLL' E
providerLLF N
)LLN O
=>LLP R
thisLLS W
.LLW X
providerLLX `
=LLa b
providerLLc k
;LLk l
publicNN 
voidNN 
	ConfigureNN 
(NN 
SwaggerGenOptionsNN /
optionsNN0 7
)NN7 8
{OO 	
foreachPP 
(PP 
varPP 
descriptionPP $
inPP% '
providerPP( 0
.PP0 1"
ApiVersionDescriptionsPP1 G
)PPG H
{QQ 
optionsRR 
.RR 

SwaggerDocRR "
(RR" #
descriptionRR# .
.RR. /
	GroupNameRR/ 8
,RR8 9#
CreateInfoForApiVersionRR: Q
(RRQ R
descriptionRRR ]
)RR] ^
)RR^ _
;RR_ `
}SS 
}TT 	
staticVV 
OpenApiInfoVV #
CreateInfoForApiVersionVV 2
(VV2 3!
ApiVersionDescriptionVV3 H
descriptionVVI T
)VVT U
{WW 	
varXX 
infoXX 
=XX 
newXX 
OpenApiInfoXX &
(XX& '
)XX' (
{YY 
TitleZZ 
=ZZ 
$strZZ (
,ZZ( )
Version[[ 
=[[ 
description[[ %
.[[% &

ApiVersion[[& 0
.[[0 1
ToString[[1 9
([[9 :
)[[: ;
,[[; <
Description\\ 
=\\ 
$str\\ 2
,\\2 3
Contact]] 
=]] 
new]] 
OpenApiContact]] ,
(]], -
)]]- .
{]]/ 0
Name]]1 5
=]]6 7
$str]]8 F
,]]F G
Email]]H M
=]]N O
$str]]P h
}]]i j
,]]j k
License^^ 
=^^ 
new^^ 
OpenApiLicense^^ ,
(^^, -
)^^- .
{^^/ 0
Name^^1 5
=^^6 7
$str^^8 =
,^^= >
Url^^? B
=^^C D
new^^E H
Uri^^I L
(^^L M
$str^^M r
)^^r s
}^^t u
}__ 
;__ 
ifaa 
(aa 
descriptionaa 
.aa 
IsDeprecatedaa (
)aa( )
{bb 
infocc 
.cc 
Descriptioncc  
+=cc! #
$strcc$ A
;ccA B
}dd 
returnff 
infoff 
;ff 
}gg 	
}hh 
}jj  
ZC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Controllers\AplicativosController.cs
	namespace		 	

TadeuStore		
 
.		 
API		 
.		 
Controllers		 $
{

 
[ 

ApiVersion 
( 
$str 
) 
] 
[ 
Route 

(
 
$str 3
)3 4
]4 5
[ 
ApiController 
] 
public 

class !
AplicativosController &
:' (
ControllerBase) 7
{ 
private 
readonly 
IMapper  
_mapper! (
;( )
private 
readonly 
IAplicativoService +
_aplicativoService, >
;> ?
public !
AplicativosController $
($ %
IMapper 
mapper 
, 
IAplicativoService 
aplicativoService 0
)0 1
{ 	
_mapper 
= 
mapper 
; 
_aplicativoService 
=  
aplicativoService! 2
;2 3
} 	
[ 	
HttpGet	 
] 
[ 	 
ProducesResponseType	 
( 
StatusCodes )
.) *
Status200OK* 5
,5 6
Type7 ;
=< =
typeof> D
(D E
IEnumerableE P
<P Q

AplicativoQ [
>[ \
)\ ]
)] ^
]^ _
public 
async 
Task 
< 
ActionResult &
>& '

ObterTodos( 2
(2 3
)3 4
{ 	
return 
Ok 
( 
await 
_aplicativoService .
.. /

ObterTodos/ 9
(9 :
): ;
); <
;< =
}   	
["" 	
HttpPost""	 
]"" 
[## 	
Route##	 
(## 
$str## "
)##" #
]### $
[$$ 	 
ProducesResponseType$$	 
($$ 
StatusCodes$$ )
.$$) *!
Status401Unauthorized$$* ?
,$$? @
Type$$A E
=$$F G
typeof$$H N
($$N O
ErroDetalhes$$O [
)$$[ \
)$$\ ]
]$$] ^
[%% 	 
ProducesResponseType%%	 
(%% 
StatusCodes%% )
.%%) *
Status200OK%%* 5
,%%5 6
Type%%7 ;
=%%< =
typeof%%> D
(%%D E.
"ComprarAplicativoRespostaViewModel%%E g
)%%g h
)%%h i
]%%i j
[&& 	
	Authorize&&	 
]&& 
public'' 
async'' 
Task'' 
<'' 
ActionResult'' &
>''& '
Comprar''( /
(''/ 0,
 CartaoCreditoRequisicaoViewModel''0 P
	viewModel''Q Z
,''Z [
Guid''\ `
id''a c
)''c d
{(( 	
var)) 
response)) 
=)) 
await))  
_aplicativoService))! 3
.))3 4
Comprar))4 ;
()); <
id))< >
,))> ?
_mapper))@ G
.))G H
Map))H K
<))K L
CartaoCredito))L Y
>))Y Z
())Z [
	viewModel))[ d
)))d e
,))e f
	viewModel))g p
.))p q
Salvar))q w
)))w x
;))x y
return** 
Ok** 
(** 
_mapper** 
.** 
Map** !
<**! ".
"ComprarAplicativoRespostaViewModel**" D
>**D E
(**E F
response**F N
)**N O
)**O P
;**P Q
}++ 	
},, 
}-- Ä
WC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Controllers\UsuariosController.cs
	namespace 	

TadeuStore
 
. 
API 
. 
Controllers $
{		 
[

 

ApiVersion

 
(

 
$str

 
)

 
]

 
[ 
Route 

(
 
$str 3
)3 4
]4 5
[ 
ApiController 
] 
public 

class 
UsuariosController #
:$ %
ControllerBase& 4
{ 
private 
readonly 
IUsuarioService (
_usuariosService) 9
;9 :
private 
readonly 
IMapper  
_mapper! (
;( )
public 
UsuariosController !
(! "
IMapper 
mapper 
, 
IUsuarioService 
usuariosRepository .
). /
{ 	
_mapper 
= 
mapper 
; 
_usuariosService 
= 
usuariosRepository 1
;1 2
} 	
[ 	
HttpPost	 
] 
[ 	 
ProducesResponseType	 
( 
StatusCodes )
.) *
Status200OK* 5
,5 6
Type7 ;
=< =
typeof> D
(D E/
#CadastrarUsuarioRequisicaoViewModelE h
)h i
)i j
]j k
public 
async 
Task 
< 
ActionResult &
>& '
	Cadastrar( 1
(1 2/
#CadastrarUsuarioRequisicaoViewModel2 U
	viewModelV _
)_ `
{ 	
return 
Ok 
( 
await 
_usuariosService ,
., -
	Adicionar- 6
(6 7
_mapper7 >
.> ?
Map? B
<B C
UsuarioC J
>J K
(K L
	viewModelL U
)U V
)V W
)W X
;X Y
} 	
["" 	
HttpPost""	 
]"" 
[## 	
Route##	 
(## 
$str## 
)## 
]## 
[$$ 	 
ProducesResponseType$$	 
($$ 
StatusCodes$$ )
.$$) *
Status200OK$$* 5
,$$5 6
Type$$7 ;
=$$< =
typeof$$> D
($$D E"
LoginRespostaViewModel$$E [
)$$[ \
)$$\ ]
]$$] ^
public%% 
async%% 
Task%% 
<%% 
ActionResult%% &
>%%& '
Logar%%( -
(%%- .$
LoginRequisicaoViewModel%%. F
	viewModel%%G P
)%%P Q
{&& 	
return'' 
Ok'' 
('' 
await'' 
_usuariosService'' ,
.'', -
Login''- 2
(''2 3
_mapper''3 :
.'': ;
Map''; >
<''> ?
Usuario''? F
>''F G
(''G H
	viewModel''H Q
)''Q R
)''R S
)''S T
;''T U
}(( 	
})) 
}** §
ZC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Filters\FluentValidationAttribute.cs
	namespace 	

TadeuStore
 
. 
API 
. 
Filters  
{ 
public 

class %
FluentValidationAttribute *
:+ ,!
ActionFilterAttribute- B
{ 
private		 
readonly		 
ILogger		  
<		  !%
FluentValidationAttribute		! :
>		: ;
_logger		< C
;		C D
public %
FluentValidationAttribute (
(( )
ILogger) 0
<0 1%
FluentValidationAttribute1 J
>J K
loggerL R
)R S
{ 	
_logger 
= 
logger 
; 
} 	
public 
override 
void 
OnActionExecuting .
(. /"
ActionExecutingContext/ E
contextF M
)M N
{ 	
if 
( 
! 
context 
. 

ModelState #
.# $
IsValid$ +
)+ ,
{ 
var 
errors 
= 
context $
.$ %

ModelState% /
./ 0
Values0 6
.6 7
Where7 <
(< =
v= >
=>? A
vB C
.C D
ErrorsD J
.J K
CountK P
>Q R
$numS T
)T U
. 

SelectMany #
(# $
v$ %
=>& (
v) *
.* +
Errors+ 1
)1 2
. 
Select 
(  
v  !
=>" $
v% &
.& '
ErrorMessage' 3
)3 4
. 
ToList 
(  
)  !
;! "
var 
result 
= 
new  
ErroDetalhes! -
(- .
). /
{ 
codigo 
= 
StatusCodes (
.( )
Status400BadRequest) <
,< =
erros 
= 
errors "
?" #
.# $
ToArray$ +
(+ ,
), -
} 
; 
context 
. 
Result 
=  
new! $

JsonResult% /
(/ 0
result0 6
)6 7
{   

StatusCode!! 
=!!  
StatusCodes!!! ,
.!!, -
Status400BadRequest!!- @
}"" 
;"" 
_logger$$ 
.$$ 
LogInformation$$ &
($$& '
$"$$' )
$str$$) @
{$$@ A
result$$A G
.$$G H
erros$$H M
}$$M N
"$$N O
)$$O P
;$$P Q
}%% 
}&& 	
}'' 
}(( ²4
GC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\MainMiddleware.cs
	namespace 	

TadeuStore
 
. 
API 
{ 
public		 

class		 
MainMiddleware		 
{

 
private 
readonly 
RequestDelegate (
_next) .
;. /
private 
readonly 
ILogger  
<  !
MainMiddleware! /
>/ 0
_logger1 8
;8 9
public 
MainMiddleware 
( 
RequestDelegate -
next. 2
,2 3
ILogger4 ;
<; <
MainMiddleware< J
>J K
loggerL R
)R S
{ 	
_next 
= 
next 
; 
_logger 
= 
logger 
; 
} 	
public 
async 
Task 
InvokeAsync %
(% &
HttpContext& 1
context2 9
)9 :
{ 	
try 
{ 
await 
_next 
( 
context #
)# $
;$ %
} 
catch 
( 
	Exception 
ex 
)  
{ 
await  
HandleExceptionAsync *
(* +
context+ 2
,2 3
ex4 6
)6 7
;7 8
} 
finally 
{ 
if   
(   
context   
.   
Response   $
.  $ %

StatusCode  % /
==  0 2
StatusCodes  3 >
.  > ?!
Status401Unauthorized  ? T
)  T U
await!! $
HandleAuthorizationAsync!! 2
(!!2 3
context!!3 :
)!!: ;
;!!; <
}"" 
}## 	
private%% 
async%% 
Task%%  
HandleExceptionAsync%% /
(%%/ 0
HttpContext%%0 ;
context%%< C
,%%C D
	Exception%%E N
ex%%O Q
)%%Q R
{&& 	
if'' 
('' 
ex'' 
is'' 
ArgumentException'' '
||''( *
ex''+ -
is''. 0!
ArgumentNullException''1 F
||''G I
ex''J L
is''M O#
NotImplementedException''P g
)''g h
{(( 
context)) 
.)) 
Response))  
.))  !

StatusCode))! +
=)), -
StatusCodes)). 9
.))9 :
Status400BadRequest)): M
;))M N
_logger** 
.** 
LogInformation** &
(**& '
$"**' )
{**) *
ex*** ,
.**, -
Message**- 4
}**4 5
$str**5 8
{**8 9
ex**9 ;
.**; <
InnerException**< J
?**J K
.**K L
Message**L S
}**S T
"**T U
)**U V
;**V W
}++ 
else,, 
{-- 
context.. 
... 
Response..  
...  !

StatusCode..! +
=.., -
StatusCodes... 9
...9 :(
Status500InternalServerError..: V
;..V W
_logger// 
.// 
LogCritical// #
(//# $
$"//$ &
{//& '
ex//' )
.//) *
Message//* 1
}//1 2
$str//2 5
{//5 6
ex//6 8
.//8 9
InnerException//9 G
?//G H
.//H I
Message//I P
}//P Q
$str//Q T
{//T U
ex//U W
.//W X

StackTrace//X b
}//b c
"//c d
)//d e
;//e f
}00 
context22 
.22 
Response22 
.22 
ContentType22 (
=22) *
$str22+ =
;22= >
List44 
<44 
string44 
>44 
erros44 
=44  
new44! $
List44% )
<44) *
string44* 0
>440 1
(441 2
)442 3
{55 
{66 
ex66 
.66 
Message66 
?66 
.66 
ToString66 &
(66& '
)66' (
??66) +
$str66, .
}66/ 0
}77 
;77 
if99 
(99 
!99 
string99 
.99 
IsNullOrEmpty99 %
(99% &
ex99& (
.99( )
InnerException99) 7
?997 8
.998 9
Message999 @
)99@ A
)99A B
erros:: 
.:: 
Add:: 
(:: 
ex:: 
.:: 
InnerException:: +
?::+ ,
.::, -
Message::- 4
)::4 5
;::5 6
var<< 
json<< 
=<< 
new<< 
ErroDetalhes<< '
(<<' (
)<<( )
{== 
codigo>> 
=>> 
context>>  
.>>  !
Response>>! )
.>>) *

StatusCode>>* 4
,>>4 5
erros?? 
=?? 
erros?? 
.?? 
ToArray?? %
(??% &
)??& '
}@@ 
;@@ 
awaitBB 
contextBB 
.BB 
ResponseBB "
.BB" #

WriteAsyncBB# -
(BB- .
JsonSerializerBB. <
.BB< =
	SerializeBB= F
(BBF G
jsonBBG K
)BBK L
)BBL M
;BBM N
}CC 	
privateEE 
asyncEE 
TaskEE $
HandleAuthorizationAsyncEE 3
(EE3 4
HttpContextEE4 ?
contextEE@ G
)EEG H
{FF 	
contextGG 
.GG 
ResponseGG 
.GG 
ContentTypeGG (
=GG) *
$strGG+ =
;GG= >
varII 
jsonII 
=II 
newII 
ErroDetalhesII '
(II' (
)II( )
{JJ 
codigoKK 
=KK 
contextKK  
.KK  !
ResponseKK! )
.KK) *

StatusCodeKK* 4
,KK4 5
errosLL 
=LL 
newLL 
stringLL "
[LL" #
]LL# $
{LL% &
$strLL' <
}LL= >
}MM 
;MM 
awaitOO 
contextOO 
.OO 
ResponseOO "
.OO" #

WriteAsyncOO# -
(OO- .
JsonSerializerOO. <
.OO< =
	SerializeOO= F
(OOF G
jsonOOG K
)OOK L
)OOL M
;OOM N
}PP 	
}QQ 
}RR ›P
@C:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.API\Program.cs
[ 
assembly 	
:	 

ApiConventionType 
( 
typeof #
(# $!
DefaultApiConventions$ 9
)9 :
): ;
]; <
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
builder 
. 
Configuration 
. 
SetBasePath 
( 
builder 
. 
Environment $
.$ %
ContentRootPath% 4
)4 5
. 
AddJsonFile 
( 
$str #
,# $
true% )
,) *
true+ /
)/ 0
. 
AddJsonFile 
( 
$" 
$str 
{  
builder  '
.' (
Environment( 3
.3 4
EnvironmentName4 C
}C D
$strD I
"I J
,J K
trueL P
,P Q
trueR V
)V W
. #
AddEnvironmentVariables 
( 
) 
; 
builder!! 
.!! 
Services!! 
.!! 
AddDbContext!! 
<!! 
MainContext!! )
>!!) *
(!!* +
o!!+ ,
=>!!- /
{"" 
o## 
.## 
UseSqlServer## 
(## 
builder## 
.## 
Configuration## (
.##( )
GetConnectionString##) <
(##< =
$str##= P
)##P Q
)##Q R
;##R S
}$$ 
)$$ 
;$$ 
builder&& 
.&& 
Services&& 
.&& $
AddDistributedRedisCache&& )
(&&) *
options&&* 1
=>&&2 4
{'' 
options(( 
.(( 
Configuration(( 
=(( 
builder(( #
.((# $
Configuration(($ 1
.((1 2

GetSection((2 <
(((< =
$str((= N
)((N O
?((O P
[((P Q
$str((Q Z
]((Z [
??((\ ^
$str((_ a
;((a b
options)) 
.)) 
InstanceName)) 
=)) 
$str)) *
;))* +
}** 
)** 
;** 
builder33 
.33 
Services33 
.33 

AddLogging33 
(33 
)33 
;33 
builder77 
.77 
Services77 
.77 
AddJwtConfig77 
(77 
)77 
;77  
builder:: 
.:: 
Services:: 
.;; 
AddControllers;; 
(;; 
o;; 
=>;; 
{<< 
o== 	
.==	 

Filters==
 
.== 
Add== 
(== 
typeof== 
(== %
FluentValidationAttribute== 6
)==6 7
)==7 8
;==8 9
o>> 	
.>>	 

Filters>>
 
.>> 
Add>> 
(>> 
new>> )
ProducesResponseTypeAttribute>> 7
(>>7 8
typeof>>8 >
(>>> ?
ErroDetalhes>>? K
)>>K L
,>>L M
$num>>N Q
)>>Q R
)>>R S
;>>S T
o?? 	
.??	 

Filters??
 
.?? 
Add?? 
(?? 
new?? )
ProducesResponseTypeAttribute?? 7
(??7 8
typeof??8 >
(??> ?
ErroDetalhes??? K
)??K L
,??L M
$num??N Q
)??Q R
)??R S
;??S T
o@@ 	
.@@	 

Filters@@
 
.@@ 
Add@@ 
(@@ 
new@@ 
ProducesAttribute@@ +
(@@+ ,
$str@@, >
)@@> ?
)@@? @
;@@@ A
}AA 
)AA 
;AA 
builderCC 
.CC 
ServicesCC 
.CC #
AddEndpointsApiExplorerCC (
(CC( )
)CC) *
;CC* +
builderDD 
.DD 
ServicesDD 
.DD 
AddSwaggerGenDD 
(DD 
)DD  
;DD  !
builderEE 
.EE 
ServicesEE 
.EE 
AddAutoMapperEE 
(EE 
	AppDomainEE (
.EE( )
CurrentDomainEE) 6
.EE6 7
GetAssembliesEE7 D
(EED E
)EEE F
.EEF G
WhereEEG L
(EEL M
pEEM N
=>EEO Q
!EER S
pEES T
.EET U
	IsDynamicEEU ^
)EE^ _
)EE_ `
;EE` a
builderGG 
.GG 
ServicesGG 
.HH 
AddFluentValidationHH 
(HH 
optionsHH  
=>HH! #
{II 
optionsJJ 
.JJ -
!ImplicitlyValidateChildPropertiesJJ 1
=JJ2 3
trueJJ4 8
;JJ8 9
optionsKK 
.KK 4
(ImplicitlyValidateRootCollectionElementsKK 8
=KK9 :
trueKK; ?
;KK? @
optionsLL 
.LL ,
 RegisterValidatorsFromAssembliesLL 0
(LL0 1
	AppDomainLL1 :
.LL: ;
CurrentDomainLL; H
.LLH I
GetAssembliesLLI V
(LLV W
)LLW X
.LLX Y
WhereLLY ^
(LL^ _
pLL_ `
=>LLa c
!LLd e
pLLe f
.LLf g
	IsDynamicLLg p
)LLp q
)LLq r
;LLr s
}MM 
)MM 
;MM 
builderOO 
.OO 
ServicesOO 
.OO 
	ConfigureOO 
<OO 
ApiBehaviorOptionsOO -
>OO- .
(OO. /
optionsOO/ 6
=>OO7 9
{PP 
optionsQQ 
.QQ +
SuppressModelStateInvalidFilterQQ +
=QQ, -
trueQQ. 2
;QQ2 3
}RR 
)RR 
;RR 
builderTT 
.TT 
ServicesTT 
.TT 
AddSwaggerConfigTT !
(TT! "
)TT" #
;TT# $
builderXX 
.XX 
ServicesXX 
.XX "
AddHttpContextAccessorXX '
(XX' (
)XX( )
;XX) *
builderZZ 
.ZZ 
ServicesZZ 
.ZZ 
AddTransientZZ 
<ZZ 
MainContextZZ )
>ZZ) *
(ZZ* +
)ZZ+ ,
;ZZ, -
builder\\ 
.\\ 
Services\\ 
.\\ 
AddTransient\\ 
<\\ 
IUsuarioService\\ -
,\\- .
UsuarioService\\/ =
>\\= >
(\\> ?
)\\? @
;\\@ A
builder]] 
.]] 
Services]] 
.]] 
AddTransient]] 
<]] 
IAplicativoService]] 0
,]]0 1
AplicativoService]]2 C
>]]C D
(]]D E
)]]E F
;]]F G
builder__ 
.__ 
Services__ 
.__ 
AddTransient__ 
<__ !
IAplicativoRepository__ 3
,__3 4 
AplicaticoRepository__5 I
>__I J
(__J K
)__K L
;__L M
builder`` 
.`` 
Services`` 
.`` 
AddTransient`` 
<`` 
IUsuarioRepository`` 0
,``0 1
UsuarioRepository``2 C
>``C D
(``D E
)``E F
;``F G
builderaa 
.aa 
Servicesaa 
.aa 
AddTransientaa 
<aa $
ICartaoCreditoRepositoryaa 6
,aa6 7#
CartaoCreditoRepositoryaa8 O
>aaO P
(aaP Q
)aaQ R
;aaR S
builderbb 
.bb 
Servicesbb 
.bb 
AddTransientbb 
<bb  
ITransacaoRepositorybb 2
,bb2 3
TransacaoRepositorybb4 G
>bbG H
(bbH I
)bbI J
;bbJ K
builderdd 
.dd 
Servicesdd 
.dd 
AddSingletondd 
<dd 
	IEventBusdd '
,dd' (
EventBusRabbitMQdd) 9
>dd9 :
(dd: ;
)dd; <
;dd< =
builderee 
.ee 
Servicesee 
.ee 
AddSingletonee 
<ee 
ICacheConnectionee .
,ee. /
CacheConnectionee0 ?
>ee? @
(ee@ A
)eeA B
;eeB C
buildergg 
.gg 
Servicesgg 
.gg 
AddTransientgg 
<gg 
IConfigureOptionsgg /
<gg/ 0
SwaggerGenOptionsgg0 A
>ggA B
,ggB C#
ConfigureSwaggerOptionsggD [
>gg[ \
(gg\ ]
)gg] ^
;gg^ _
varll 
appll 
=ll 	
builderll
 
.ll 
Buildll 
(ll 
)ll 
;ll 
varmm )
apiVersionDescriptionProvidermm !
=mm" #
appmm$ '
.mm' (
Servicesmm( 0
.mm0 1
GetRequiredServicemm1 C
<mmC D*
IApiVersionDescriptionProvidermmD b
>mmb c
(mmc d
)mmd e
;mme f
appoo 
.oo 
UseMiddlewareoo 
<oo 
MainMiddlewareoo  
>oo  !
(oo! "
)oo" #
;oo# $
appss 
.ss 

UseSwaggerss 
(ss 
)ss 
;ss 
apptt 
.tt 
UseSwaggerConfigtt 
(tt )
apiVersionDescriptionProvidertt 2
)tt2 3
;tt3 4
appuu 
.uu 
UseHttpsRedirectionuu 
(uu 
)uu 
;uu 
appww 
.ww 
UseAuthenticationww 
(ww 
)ww 
;ww 
appxx 
.xx 
UseAuthorizationxx 
(xx 
)xx 
;xx 
appzz 
.zz 
MapControllerszz 
(zz 
)zz 
;zz 
app|| 
.|| 
Run|| 
(|| 
)|| 	
;||	 
