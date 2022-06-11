¡6
JC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Consumer\ConsumerBase.cs
	namespace		 	

TadeuStore		
 
.		 
Consumer		 
{

 
public 

abstract 
class 
ConsumerBase &
:' (
BackgroundService) :
,: ;
IDisposable< G
{ 
private 
readonly  
ITransacaoRepository - 
_transacaoRepository. B
;B C
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
private 
readonly 

Dictionary #
<# $
string$ *
,* +
EventHandler, 8
>8 9
_subscriptions: H
;H I
	protected 
delegate 
Task 
<  
ResponseMessage  /
>/ 0
EventHandler1 =
(> ?$
IIntegrationEventHandler? W
handlerX _
)_ `
;` a
public 
ConsumerBase 
(  
ITransacaoRepository  
transacaoRepository! 4
,4 5
IConfiguration 
configuration (
)( )
{ 	
_subscriptions 
= 
new  

Dictionary! +
<+ ,
string, 2
,2 3
EventHandler4 @
>@ A
(A B
)B C
;C D 
_transacaoRepository  
=! "
transacaoRepository# 6
;6 7
_configuration 
= 
configuration *
;* +
} 	
	protected 
abstract 
void 

TryConnect  *
(* +
)+ ,
;, -
	protected 
void !
CarregarSubscriptions ,
(, -
)- .
{   	
AddSubscription!! 
(!! 
nameof!! "
(!!" #.
"AutorizarPagamentoIntegrationEvent!!# E
)!!E F
,!!F G
AutorizarPagamento!!H Z
)!!Z [
;!![ \
}"" 	
	protected$$ 
virtual$$ 
void$$ 
AddSubscription$$ .
($$. /
string$$/ 5
	eventName$$6 ?
,$$? @
EventHandler$$A M
handle$$N T
)$$T U
{%% 	
if&& 
(&& 
!&& 
HasSubscription&&  
(&&  !
	eventName&&! *
)&&* +
)&&+ ,
_subscriptions'' 
.'' 
Add'' "
(''" #
	eventName''# ,
,'', -
handle''. 4
)''4 5
;''5 6
}(( 	
public** 
bool** 
HasSubscription** #
(**# $
string**$ *
	eventName**+ 4
)**4 5
=>**6 8
_subscriptions**9 G
.**G H
ContainsKey**H S
(**S T
	eventName**T ]
)**] ^
;**^ _
public,, 
Task,, 
<,, 
ResponseMessage,, #
>,,# $
ExecuteEvent,,% 1
(,,1 2
string,,2 8
	eventName,,9 B
,,,B C$
IIntegrationEventHandler,,D \
@event,,] c
),,c d
=>,,e g
_subscriptions,,h v
[,,v w
	eventName	,,w Ä
]
,,Ä Å
.
,,Å Ç
Invoke
,,Ç à
(
,,à â
@event
,,â è
)
,,è ê
;
,,ê ë
public.. 
async.. 
Task.. 
<.. 
ResponseMessage.. )
>..) *
AutorizarPagamento..+ =
(..= >$
IIntegrationEventHandler..> V
@event..W ]
)..] ^
{// 	
Console00 
.00 
	WriteLine00 
(00 
$"00  
{00  !
nameof00! '
(00' (
AutorizarPagamento00( :
)00: ;
}00; <
$str00< O
"00O P
)00P Q
;00Q R
ValidationResult22 
validationResult22 -
=22. /
new220 3
ValidationResult224 D
(22D E
)22E F
;22F G
try44 
{55 
var66 
eventAutorizar66 "
=66# $
@event66% +
as66, ..
"AutorizarPagamentoIntegrationEvent66/ Q
;66Q R$
TipoAutorizacaoTransacao88 (
tipoAutorizacao88) 8
=889 :$
TipoAutorizacaoTransacao88; S
.88S T
Aprovado88T \
;88\ ]
Console:: 
.:: 
	WriteLine:: !
(::! "
$"::" $
$str::$ .
{::. /
this::/ 3
.::3 4
GetType::4 ;
(::; <
)::< =
.::= >
Name::> B
}::B C
$str::C P
{::P Q
eventAutorizar::Q _
?::_ `
.::` a
IdTransacao::a l
}::l m
$str::m q
{::q r
tipoAutorizacao	::r Å
}
::Å Ç
"
::Ç É
)
::É Ñ
;
::Ñ Ö
var<< 
	transacao<< 
=<< 
await<<  % 
_transacaoRepository<<& :
.<<: ;

ObterPorId<<; E
(<<E F
eventAutorizar<<F T
.<<T U
IdTransacao<<U `
)<<` a
;<<a b
if>> 
(>> 
	transacao>> 
!=>>  
null>>! %
)>>% &
{?? 
	transacao@@ 
.@@ 
StatusAutorizacao@@ /
=@@0 1
(@@2 3
int@@3 6
)@@6 7
tipoAutorizacao@@7 F
;@@F G
awaitAA  
_transacaoRepositoryAA .
.AA. /
	AtualizarAA/ 8
(AA8 9
	transacaoAA9 B
)AAB C
;AAC D
}BB 
}CC 
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD 
{EE 
validationResultFF  
.FF  !
ErrorsFF! '
.FF' (
AddFF( +
(FF+ ,
newFF, /
ValidationFailureFF0 A
(FFA B
exFFB D
.FFD E
MessageFFE L
,FFL M
exFFN P
.FFP Q

StackTraceFFQ [
)FF[ \
)FF\ ]
;FF] ^
ConsoleGG 
.GG 
	WriteLineGG !
(GG! "
$"GG" $
$strGG$ L
{GGL M
nameofGGM S
(GGS T
AutorizarPagamentoGGT f
)GGf g
}GGg h
$strGGh j
{GGj k
exGGk m
.GGm n
MessageGGn u
}GGu v
"GGv w
)GGw x
;GGx y
}HH 
returnJJ 
awaitJJ 
TaskJJ 
.JJ 
RunJJ !
(JJ! "
(JJ" #
)JJ# $
=>JJ% '
newJJ( +
ResponseMessageJJ, ;
(JJ; <
validationResultJJ< L
)JJL M
)JJM N
;JJN O
}KK 	
}LL 
}MM Ñ?
OC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Consumer\EasyNetQ_Consumer.cs
	namespace 	

TadeuStore
 
. 
Consumer 
{ 
public 

class 
EasyNetQ_Consumer "
:# $
ConsumerBase% 1
{ 
private 
readonly 
string 
_connectionString  1
;1 2
private 
readonly 
ILogger  
<  !
EasyNetQ_Consumer! 2
>2 3
_logger4 ;
;; <
private 
IBus 
_bus 
; 
public 
EasyNetQ_Consumer  
(  ! 
ITransacaoRepository  
transacaoRepository! 4
,4 5
IConfiguration 
configuration (
,( )
ILogger 
< 
EasyNetQ_Consumer %
>% &
logger' -
)- .
: 
base 
( 
transacaoRepository %
,% &
configuration 
)  
{ 	
_logger   
=   
logger   
;   
_connectionString!! 
=!! 
configuration!!  -
.!!- .

GetSection!!. 8
(!!8 9
$str!!9 R
)!!R S
?!!S T
[!!T U
$str!!U _
]!!_ `
??!!a c
$str!!d f
;!!f g
}"" 	
	protected$$ 
async$$ 
override$$  
Task$$! %
ExecuteAsync$$& 2
($$2 3
CancellationToken$$3 D
stoppingToken$$E R
)$$R S
{%% 	
Console&& 
.&& 
	WriteLine&& 
(&& 
$"&&  
$str&&  *
{&&* +
nameof&&+ 1
(&&1 2
EasyNetQ_Consumer&&2 C
)&&C D
}&&D E
$str&&E H
"&&H I
)&&I J
;&&J K!
CarregarSubscriptions(( !
(((! "
)((" #
;((# $
})) 	
	protected++ 
override++ 
void++ 

TryConnect++  *
(++* +
)+++ ,
{,, 	
try-- 
{.. 
if// 
(// 
_bus// 
?// 
.// 
Advanced// "
?//" #
.//# $
IsConnected//$ /
??//0 2
false//3 8
)//8 9
return00 
;00 
var22 
policy22 
=22 
Policy22 #
.33 
Handle33 
<33 
EasyNetQException33 -
>33- .
(33. /
)33/ 0
.44 
Or44 
<44 &
BrokerUnreachableException44 2
>442 3
(443 4
)444 5
.55 
WaitAndRetry55 !
(55! "
$num55" #
,55# $
retryAttempt55% 1
=>552 4
TimeSpan555 =
.55= >
FromSeconds55> I
(55I J
Math55J N
.55N O
Pow55O R
(55R S
$num55S T
,55T U
retryAttempt55V b
)55b c
)55c d
,55d e
(55f g
ex55g i
,55i j
time55k o
,55o p
retry55q v
)55v w
=>55x z
{66 
_logger77 
.77  

LogWarning77  *
(77* +
$"77+ -
{77- .
retry77. 3
}773 4
$str774 O
{77O P
ex77P R
.77R S
Message77S Z
}77Z [
"77[ \
)77\ ]
;77] ^
}88 
)88 
;88 
policy:: 
.:: 
Execute:: 
(:: 
(::  
)::  !
=>::" $
{;; 
_bus<< 
=<< 
RabbitHutch<< &
.<<& '
	CreateBus<<' 0
(<<0 1
_connectionString<<1 B
)<<B C
;<<C D
}== 
)== 
;== 
}>> 
catch?? 
(?? 
	Exception?? 
ex?? 
)??  
{@@ 
_loggerAA 
.AA 
LogErrorAA  
(AA  !
-AA! "
$numAA" #
,AA# $
exAA% '
,AA' (
$strAA) P
)AAP Q
;AAQ R
}BB 
}CC 	
	protectedEE 
overrideEE 
asyncEE  
voidEE! %
AddSubscriptionEE& 5
(EE5 6
stringEE6 <
	eventNameEE= F
,EEF G
EventHandlerEEH T
eventHandlerEEU a
)EEa b
{FF 	

TryConnectGG 
(GG 
)GG 
;GG 
baseII 
.II 
AddSubscriptionII  
(II  !
	eventNameII! *
,II* +
eventHandlerII, 8
)II8 9
;II9 :
awaitKK 
_busKK 
.KK 
PubSubKK 
.KK 
SubscribeAsyncKK ,
<KK, -$
IIntegrationEventHandlerKK- E
>KKE F
(KKF G
	eventNameKKG P
,KKP Q
msgKKR U
=>KKV X
ProcessEventKKY e
(KKe f
	eventNameKKf o
,KKo p
msgKKq t
)KKt u
)KKu v
;KKv w
}MM 	
privateNN 
asyncNN 
TaskNN 
<NN 
ResponseMessageNN *
>NN* +
ProcessEventNN, 8
(NN8 9
stringNN9 ?
	eventNameNN@ I
,NNI J$
IIntegrationEventHandlerNNK c
messageNNd k
)NNk l
{OO 	
tryPP 
{QQ 
ifRR 
(RR 
HasSubscriptionRR #
(RR# $
	eventNameRR$ -
)RR- .
)RR. /
{SS 
varTT 
resultTT 
=TT  
awaitTT! &
ExecuteEventTT' 3
(TT3 4
	eventNameTT4 =
,TT= >
messageTT? F
)TTF G
;TTG H
ifVV 
(VV 
!VV 
resultVV 
.VV  
ValidationResultVV  0
.VV0 1
IsValidVV1 8
)VV8 9
{WW 
varXX 
errorMessageXX (
=XX) *
$strXX+ -
;XX- .
resultYY 
.YY 
ValidationResultYY /
.YY/ 0
ErrorsYY0 6
.YY6 7
ForEachYY7 >
(YY> ?
xYY? @
=>YYA C
errorMessageYYD P
+=YYQ S
$"YYT V
{YYV W
xYYW X
.YYX Y
	ErrorCodeYYY b
}YYb c
$strYYc f
{YYf g
xYYg h
.YYh i
ErrorMessageYYi u
}YYu v
$strYYv x
"YYx y
)YYy z
;YYz {
throwZZ 
newZZ !
	ExceptionZZ" +
(ZZ+ ,
errorMessageZZ, 8
)ZZ8 9
;ZZ9 :
}[[ 
}\\ 
}]] 
catch^^ 
(^^ 
	Exception^^ 
ex^^ 
)^^  
{__ 
_logger`` 
.`` 
LogError``  
(``  !
-``! "
$num``" #
,``# $
ex``% '
,``' (
$str``) F
)``F G
;``G H
throwaa 
;aa 
}bb 
returndd 
awaitdd 
Taskdd 
.dd 
Rundd !
(dd! "
(dd" #
)dd# $
=>dd% '
newdd( +
ResponseMessagedd, ;
(dd; <
newdd< ?
FluentValidationdd@ P
.ddP Q
ResultsddQ X
.ddX Y
ValidationResultddY i
(ddi j
)ddj k
)ddk l
)ddl m
;ddm n
}ee 	
publicgg 
overridegg 
voidgg 
Disposegg $
(gg$ %
)gg% &
{hh 	
_busii 
?ii 
.ii 
Disposeii 
(ii 
)ii 
;ii 
basejj 
.jj 
Disposejj 
(jj 
)jj 
;jj 
}kk 	
}ll 
}mm Ò
EC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Consumer\Program.cs
IHost

 
host

 

=

 
Host

 
.

  
CreateDefaultBuilder

 &
(

& '
args

' +
)

+ ,
. 	
ConfigureServices	 
( 
( 
ctx 
,  
services! )
)) *
=>+ -
{ 	
services 
. 
AddDbContext !
<! "
MainContext" -
>- .
(. /
o/ 0
=>1 3
{ 
o 
. 
UseSqlServer 
( 
ctx "
." #
Configuration# 0
.0 1
GetConnectionString1 D
(D E
$strE X
)X Y
)Y Z
;Z [
} 
) 
; 
services 
. 
AddTransient !
<! "
MainContext" -
>- .
(. /
)/ 0
;0 1
services 
. 
AddTransient !
<! " 
ITransacaoRepository" 6
,6 7
TransacaoRepository8 K
>K L
(L M
)M N
;N O
services 
. 
AddHostedService %
<% &
RabbitMQ_Consumer& 7
>7 8
(8 9
)9 :
;: ;
} 	
)	 

. 	
UseEnvironment	 
( 
Environment #
.# $"
GetEnvironmentVariable$ :
(: ;
$str; S
)S T
??U W
$strX Z
)Z [
. 	
Build	 
( 
) 
; 
await 
host 

.
 
RunAsync 
( 
) 
; Éd
OC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Consumer\RabbitMQ_Consumer.cs
	namespace 	

TadeuStore
 
. 
Consumer 
{ 
public 

class 
RabbitMQ_Consumer "
:# $
ConsumerBase% 1
{ 
private 
readonly 
string 
_connectionString  1
;1 2
private 
readonly 
ILogger  
<  !
RabbitMQ_Consumer! 2
>2 3
_logger4 ;
;; <
private 
IConnection 
_connection '
;' (
private 
IModel 
_channel 
;  
public 
RabbitMQ_Consumer  
(  ! 
ITransacaoRepository  
transacaoRepository! 4
,4 5
IConfiguration 
configuration (
,( )
ILogger 
< 
RabbitMQ_Consumer %
>% &
logger' -
)- .
: 
base 
( 
transacaoRepository %
,% &
configuration   
)    
{!! 	
_logger"" 
="" 
logger"" 
;"" 
_connectionString## 
=## 
configuration##  -
.##- .

GetSection##. 8
(##8 9
$str##9 R
)##R S
?##S T
[##T U
$str##U ^
]##^ _
??##` b
$str##c e
;##e f
}$$ 	
	protected&& 
async&& 
override&&  
Task&&! %
ExecuteAsync&&& 2
(&&2 3
CancellationToken&&3 D
stoppingToken&&E R
)&&R S
{'' 	
Console(( 
.(( 
	WriteLine(( 
((( 
$"((  
$str((  *
{((* +
nameof((+ 1
(((1 2
RabbitMQ_Consumer((2 C
)((C D
}((D E
$str((E H
"((H I
)((I J
;((J K!
CarregarSubscriptions** !
(**! "
)**" #
;**# $
}++ 	
	protected-- 
override-- 
void-- 

TryConnect--  *
(--* +
)--+ ,
{.. 	
try// 
{00 
if11 
(11 
_connection11 
?11  
.11  !
IsOpen11! '
??11( *
false11+ 0
)110 1
return22 
;22 
var44 
factory44 
=44 
new44 !
ConnectionFactory44" 3
(443 4
)444 5
{55 
Uri66 
=66 
new66 
Uri66 !
(66! "
_connectionString66" 3
)663 4
,664 5&
RequestedConnectionTimeout77 .
=77/ 0
TimeSpan771 9
.779 :
FromSeconds77: E
(77E F
$num77F H
)77H I
,77I J
ContinuationTimeout88 '
=88( )
TimeSpan88* 2
.882 3
FromSeconds883 >
(88> ?
$num88? A
)88A B
,88B C
RequestedHeartbeat99 &
=99' (
TimeSpan99) 1
.991 2
FromSeconds992 =
(99= >
$num99> @
)99@ A
,99A B
}:: 
;:: 
var<< 
policy<< 
=<< 
Policy<< #
.== 
Handle== 
<== 
SocketException== +
>==+ ,
(==, -
)==- .
.>> 
Or>> 
<>> &
BrokerUnreachableException>> 2
>>>2 3
(>>3 4
)>>4 5
.?? 
WaitAndRetry?? !
(??! "
$num??" #
,??# $
retryAttempt??% 1
=>??2 4
TimeSpan??5 =
.??= >
FromSeconds??> I
(??I J
Math??J N
.??N O
Pow??O R
(??R S
$num??S T
,??T U
retryAttempt??V b
)??b c
)??c d
,??d e
(??f g
ex??g i
,??i j
time??k o
,??o p
retry??q v
)??v w
=>??x z
{@@ 
_loggerAA 
.AA  

LogWarningAA  *
(AA* +
$"AA+ -
{AA- .
retryAA. 3
}AA3 4
$strAA4 O
{AAO P
exAAP R
.AAR S
MessageAAS Z
}AAZ [
"AA[ \
)AA\ ]
;AA] ^
}BB 
)BB 
;BB 
policyDD 
.DD 
ExecuteDD 
(DD 
(DD  
)DD  !
=>DD" $
{EE 
_connectionFF 
=FF  !
factoryFF" )
.FF) *
CreateConnectionFF* :
(FF: ;
)FF; <
;FF< =
}GG 
)GG 
;GG 
policyJJ 
.JJ 
ExecuteJJ 
(JJ 
(JJ  
)JJ  !
=>JJ" $
{KK 
_channelLL 
=LL 
_connectionLL *
?LL* +
.LL+ ,
CreateModelLL, 7
(LL7 8
)LL8 9
;LL9 :
}MM 
)MM 
;MM 
}OO 
catchPP 
(PP 
	ExceptionPP 
exPP 
)PP  
{QQ 
_loggerRR 
.RR 
LogErrorRR  
(RR  !
-RR! "
$numRR" #
,RR# $
exRR% '
,RR' (
$strRR) P
)RRP Q
;RRQ R
}SS 
}UU 	
	protectedWW 
overrideWW 
voidWW 
AddSubscriptionWW  /
(WW/ 0
stringWW0 6
	eventNameWW7 @
,WW@ A
EventHandlerWWB N
eventHandlerWWO [
)WW[ \
{XX 	

TryConnectYY 
(YY 
)YY 
;YY 
base[[ 
.[[ 
AddSubscription[[  
([[  !
	eventName[[! *
,[[* +
eventHandler[[, 8
)[[8 9
;[[9 :
_channel]] 
.]] 
QueueDeclare]] !
(]]! "
queue]]" '
:]]' (
	eventName]]) 2
,]]2 3
durable^^  '
:^^' (
false^^) .
,^^. /
	exclusive__  )
:__) *
false__+ 0
,__0 1

autoDelete``  *
:``* +
false``, 1
,``1 2
	argumentsaa  )
:aa) *
nullaa+ /
)aa/ 0
;aa0 1
varcc 
consumercc 
=cc 
newcc !
EventingBasicConsumercc 4
(cc4 5
_channelcc5 =
)cc= >
;cc> ?
consumeree 
.ee 
Receivedee 
+=ee  
Consumer_Receivedee! 2
;ee2 3
_channelgg 
.gg 
BasicConsumegg !
(gg! "
queuehh 
:hh 
	eventNamehh  
,hh  !
autoAckii 
:ii 
falseii 
,ii 
consumerjj 
:jj 
consumerjj "
)jj" #
;jj# $
}ll 	
privatenn 
asyncnn 
voidnn 
Consumer_Receivednn ,
(nn, -
objectnn- 3
sendernn4 :
,nn: ;!
BasicDeliverEventArgsnn< Q
	eventArgsnnR [
)nn[ \
{oo 	
varpp 
	eventNamepp 
=pp 
	eventArgspp %
.pp% &

RoutingKeypp& 0
;pp0 1
varqq 
messageqq 
=qq 
Encodingqq "
.qq" #
UTF8qq# '
.qq' (
	GetStringqq( 1
(qq1 2
	eventArgsqq2 ;
.qq; <
Bodyqq< @
.qq@ A
SpanqqA E
)qqE F
;qqF G
tryss 
{tt 
awaitww 
ProcessEventww "
(ww" #
	eventNameww# ,
,ww, -
messageww. 5
)ww5 6
;ww6 7
_channelyy 
.yy 
BasicAckyy !
(yy! "
	eventArgsyy" +
.yy+ ,
DeliveryTagyy, 7
,yy7 8
multipleyy9 A
:yyA B
falseyyC H
)yyH I
;yyI J
}zz 
catch{{ 
({{ 
	Exception{{ 
ex{{ 
){{  
{|| 
_channel}} 
.}} 
	BasicNack}} "
(}}" #
	eventArgs}}# ,
.}}, -
DeliveryTag}}- 8
,}}8 9
multiple}}: B
:}}B C
false}}D I
,}}I J
true}}K O
)}}O P
;}}P Q
_logger~~ 
.~~ 
LogError~~  
(~~  !
-~~! "
$num~~" #
,~~# $
ex~~% '
,~~' (
$str~~) F
)~~F G
;~~G H
} 
}
ÄÄ 	
private
ÇÇ 
async
ÇÇ 
Task
ÇÇ 
<
ÇÇ 
ResponseMessage
ÇÇ *
>
ÇÇ* +
ProcessEvent
ÇÇ, 8
(
ÇÇ8 9
string
ÇÇ9 ?
	eventName
ÇÇ@ I
,
ÇÇI J
string
ÇÇK Q
message
ÇÇR Y
)
ÇÇY Z
{
ÉÉ 	
Type
ÑÑ 
type
ÑÑ 
=
ÑÑ 
	AppDomain
ÑÑ !
.
ÑÑ! "
CurrentDomain
ÑÑ" /
.
ÑÑ/ 0
GetAssemblies
ÑÑ0 =
(
ÑÑ= >
)
ÑÑ> ?
.
ÑÑ? @

SelectMany
ÑÑ@ J
(
ÑÑJ K
x
ÑÑK L
=>
ÑÑM O
x
ÑÑP Q
.
ÑÑQ R
GetTypes
ÑÑR Z
(
ÑÑZ [
)
ÑÑ[ \
)
ÑÑ\ ]
.
ÑÑ] ^
First
ÑÑ^ c
(
ÑÑc d
x
ÑÑd e
=>
ÑÑf h
x
ÑÑi j
.
ÑÑj k
Name
ÑÑk o
==
ÑÑp r
	eventName
ÑÑs |
)
ÑÑ| }
;
ÑÑ} ~
var
ÜÜ 
	eventData
ÜÜ 
=
ÜÜ 
JsonConvert
ÜÜ '
.
ÜÜ' (
DeserializeObject
ÜÜ( 9
(
ÜÜ9 :
message
ÜÜ: A
,
ÜÜA B
type
ÜÜC G
)
ÜÜG H
;
ÜÜH I
if
àà 
(
àà 
HasSubscription
àà 
(
àà  
	eventName
àà  )
)
àà) *
)
àà* +
{
ââ 
var
ää 
result
ää 
=
ää 
await
ää "
ExecuteEvent
ää# /
(
ää/ 0
	eventName
ää0 9
,
ää9 :
(
ää; <&
IIntegrationEventHandler
ää< T
)
ääT U
	eventData
ääU ^
)
ää^ _
;
ää_ `
if
åå 
(
åå 
!
åå 
result
åå 
.
åå 
ValidationResult
åå ,
.
åå, -
IsValid
åå- 4
)
åå4 5
{
çç 
var
éé 
errorMessage
éé $
=
éé% &
$str
éé' )
;
éé) *
result
èè 
.
èè 
ValidationResult
èè +
.
èè+ ,
Errors
èè, 2
.
èè2 3
ForEach
èè3 :
(
èè: ;
x
èè; <
=>
èè= ?
errorMessage
èè@ L
+=
èèM O
$"
èèP R
{
èèR S
x
èèS T
.
èèT U
	ErrorCode
èèU ^
}
èè^ _
$str
èè_ b
{
èèb c
x
èèc d
.
èèd e
ErrorMessage
èèe q
}
èèq r
$str
èèr t
"
èèt u
)
èèu v
;
èèv w
throw
êê 
new
êê 
	Exception
êê '
(
êê' (
errorMessage
êê( 4
)
êê4 5
;
êê5 6
}
ëë 
}
íí 
return
îî 
await
îî 
Task
îî 
.
îî 
Run
îî !
(
îî! "
(
îî" #
)
îî# $
=>
îî% '
new
îî( +
ResponseMessage
îî, ;
(
îî; <
new
îî< ?
FluentValidation
îî@ P
.
îîP Q
Results
îîQ X
.
îîX Y
ValidationResult
îîY i
(
îîi j
)
îîj k
)
îîk l
)
îîl m
;
îîm n
}
ïï 	
public
óó 
override
óó 
void
óó 
Dispose
óó $
(
óó$ %
)
óó% &
{
òò 	
_channel
ôô 
?
ôô 
.
ôô 
Close
ôô 
(
ôô 
)
ôô 
;
ôô 
_connection
öö 
?
öö 
.
öö 
Close
öö 
(
öö 
)
öö  
;
öö  !
_channel
õõ 
?
õõ 
.
õõ 
Dispose
õõ 
(
õõ 
)
õõ 
;
õõ  
_connection
úú 
?
úú 
.
úú 
Dispose
úú  
(
úú  !
)
úú! "
;
úú" #
base
ûû 
.
ûû 
Dispose
ûû 
(
ûû 
)
ûû 
;
ûû 
}
üü 	
}
†† 
}°° 