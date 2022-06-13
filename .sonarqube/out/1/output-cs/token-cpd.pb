�1
bC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Infra.CrossCutting\EventsBus\EventBusEasyNetQ.cs
	namespace

 	

TadeuStore


 
.

 
Infra

 
.

 
CrossCutting

 '
.

' (
	EventsBus

( 1
{ 
public 

class 
EventBusEasyNetQ !
:" #
	IEventBus$ -
{
private 
readonly 
string 
_connectionString  1
;1 2
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
ILogger 
< 
EventBusEasyNetQ  
>  !
_logger" )
;) *
private 
IBus 
_bus 
; 
public 
EventBusEasyNetQ 
(  
IConfiguration 

,( )
ILogger 
< 
EventBusEasyNetQ $
>$ %
logger& ,
), -
{ 	
_configuration 
= 

;* +
_logger 
= 
logger 
; 
_connectionString 
= 
_configuration  .
?. /
./ 0

GetSection0 :
(: ;
$str; T
)T U
?U V
[V W
$strW a
]a b
??c e
$strf h
;h i
} 	
private 
void 

TryConnect 
(  
)  !
{ 	
if 
( 
_bus 
? 
. 
Advanced 
? 
.  
IsConnected  +
??, .
false/ 4
)4 5
return 
; 
var!! 
policy!! 
=!! 
Policy!! 
."" 
Handle"" 
<"" 
EasyNetQException"" )
>"") *
(""* +
)""+ ,
.## 
Or## 
<## &
BrokerUnreachableException## .
>##. /
(##/ 0
)##0 1
.$$ 
WaitAndRetry$$ 
($$ 
$num$$ 
,$$  
retry$$! &
=>$$' )
TimeSpan$$* 2
.$$2 3
FromSeconds$$3 >
($$> ?
retry$$? D
*$$E F
$num$$G H
)$$H I
,$$I J
($$K L
ex$$L N
,$$N O
time$$P T
)$$T U
=>$$V X
{%% 
_logger&& 
.&& 

LogWarning&& &
(&&& '
ex&&' )
,&&) *
$str&&+ r
,&&r s
$"&&t v
{&&v w
time&&w {
.&&{ |
TotalSeconds	&&| �
:
&&� �
$str
&&� �
}
&&� �
"
&&� �
,
&&� �
ex
&&� �
.
&&� �
Message
&&� �
)
&&� �
;
&&� �
}'' 
)'' 
;'' 
policy)) 
.)) 
Execute)) 
()) 
()) 
))) 
=>))  
{))! "
_bus))# '
=))( )
RabbitHutch))* 5
.))5 6
	CreateBus))6 ?
())? @
_connectionString))@ Q
)))Q R
;))R S
}))T U
)))U V
;))V W
}** 	
public,, 
static,, 
Type,, $
GetAnyObjectInstanceType,, 3
(,,3 4
object,,4 :

someObject,,; E
),,E F
{-- 	
return.. 

someObject.. 
... 
GetType.. %
(..% &
)..& '
;..' (
}// 	
public11 
async11 
void11 
Publish11 !
(11! "
IntegrationEvent11" 2
@event113 9
)119 :
{22 	

TryConnect33 
(33 
)33 
;33 
var55 
policy55 
=55 
Policy55 
.66 
Handle66
<66 
EasyNetQException66 %
>66% &
(66& '
)66' (
.77 
Or77
<77 &
BrokerUnreachableException77 *
>77* +
(77+ ,
)77, -
.88 
WaitAndRetry88
(88 
$num88 
,88 
retry88 "
=>88# %
TimeSpan88& .
.88. /
FromSeconds88/ :
(88: ;
retry88; @
*88A B
$num88C D
)88D E
,88E F
(88G H
ex88H J
,88J K
time88L P
)88P Q
=>88R T
{99 
_logger:: 
.:: 

LogWarning:: "
(::" #
ex::# %
,::% &
$str::' t
,::t u
@event::v |
.::| }
Id::} 
,	:: �
$"
::� �
{
::� �
time
::� �
.
::� �
TotalSeconds
::� �
:
::� �
$str
::� �
}
::� �
"
::� �
,
::� �
ex
::� �
.
::� �
Message
::� �
)
::� �
;
::� �
};; 
);;
;;; 
await== 
policy== 
.== 
Execute==  
(==  !
(==! "
)==" #
=>==$ &
_bus==' +
.==+ ,
PubSub==, 2
.==2 3
PublishAsync==3 ?
<==? @$
IIntegrationEventHandler==@ X
>==X Y
(==Y Z
@event==Z `
)==` a
)==a b
;==b c
}>> 	
public@@ 
void@@ 
	Subscribe@@ 
<@@ 
TRequest@@ &
,@@& '
	TResponse@@( 1
>@@1 2
(@@2 3
)@@3 4
whereAA 
TRequestAA 
:AA 
IntegrationEventAA -
whereBB 
	TResponseBB 
:BB 
ResponseMessageBB -
{CC 	
throwDD 
newDD #
NotImplementedExceptionDD -
(DD- .
)DD. /
;DD/ 0
}EE 	
publicFF 
voidFF 
DisposeFF 
(FF 
)FF 
{GG 	
_busHH 
?HH 
.HH 
DisposeHH 
(HH 
)HH 
;HH 
}II 	
}JJ 
}KK �I
bC:\Users\Tadeu\source\repos\TadeuStore\TadeuStore.Infra.CrossCutting\EventsBus\EventBusRabbitMQ.cs
	namespace 	

TadeuStore
 
. 
Infra 
. 
CrossCutting '
.' (
	EventsBus( 1
{ 
public 

class 
EventBusRabbitMQ !
:" #
	IEventBus$ -
{ 
const 
int 
_retryCount 
= 
$num  !
;! "
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
private 
readonly 
string 
_connectionString  1
;1 2
ILogger 
< 
EventBusRabbitMQ  
>  !
_logger" )
;) *
private 
IConnection 
_connection '
;' (
private 
IModel 
_channel 
;  
public 
EventBusRabbitMQ 
(  
IConfiguration 

,( )
ILogger 
< 
EventBusRabbitMQ $
>$ %
logger& ,
), -
{ 	
_logger 
= 
logger 
; 
_configuration   
=   

;  * +
_connectionString!! 
=!! 
_configuration!!  .
?!!. /
.!!/ 0

GetSection!!0 :
(!!: ;
$str!!; T
)!!T U
?!!U V
[!!V W
$str!!W `
]!!` a
??!!b d
$str!!e g
;!!g h
}"" 	
private$$ 
void$$ 

TryConnect$$ 
($$  
)$$  !
{%% 	
if&& 
(&& 
_connection&& 
?&& 
.&& 
IsOpen&& #
??&&$ &
false&&' ,
)&&, -
return'' 
;'' 
try)) 
{** 
var++ 
factory++ 
=++ 
new++ !
ConnectionFactory++" 3
(++3 4
)++4 5
{,, 
Uri-- 
=-- 
new-- 
Uri-- !
(--! "
_connectionString--" 3
)--3 4
,--4 5&
RequestedConnectionTimeout.. .
=../ 0
TimeSpan..1 9
...9 :
FromSeconds..: E
(..E F
$num..F H
)..H I
,..I J
ContinuationTimeout// '
=//( )
TimeSpan//* 2
.//2 3
FromSeconds//3 >
(//> ?
$num//? A
)//A B
,//B C
RequestedHeartbeat00 &
=00' (
TimeSpan00) 1
.001 2
FromSeconds002 =
(00= >
$num00> @
)00@ A
,00A B
}11 
;11 
var33 
policy33 
=33 
Policy33 #
.44 
Handle44 
<44 
SocketException44 +
>44+ ,
(44, -
)44- .
.55 
Or55 
<55 &
BrokerUnreachableException55 2
>552 3
(553 4
)554 5
.66 
WaitAndRetry66 !
(66! "
_retryCount66" -
,66- .
retryAttempt66/ ;
=>66< >
TimeSpan66? G
.66G H
FromSeconds66H S
(66S T
Math66T X
.66X Y
Pow66Y \
(66\ ]
$num66] ^
,66^ _
retryAttempt66` l
)66l m
)66m n
,66n o
(66p q
ex66q s
,66s t
time66u y
,66y z
retry	66{ �
,
66� �
context
66� �
)
66� �
=>
66� �
{77 
_logger88 
.88  

LogWarning88  *
(88* +
ex88+ -
,88- .
$str88/ q
,88q r
$"88s u
{88u v
time88v z
.88z {
TotalSeconds	88{ �
:
88� �
$str
88� �
}
88� �
"
88� �
,
88� �
ex
88� �
.
88� �
Message
88� �
)
88� �
;
88� �
}99 
):: 
;:: 
policy<< 
.<< 
Execute<< 
(<< 
(<<  
)<<  !
=><<" $
{== 
_connection>> 
=>>  !
factory>>" )
.>>) *
CreateConnection>>* :
(>>: ;
)>>; <
;>>< =
}?? 
)?? 
;?? 
policyAA 
.AA 
ExecuteAA 
(AA 
(AA  
)AA  !
=>AA" $
{BB 
_channelCC 
=CC 
_connectionCC *
?CC* +
.CC+ ,
CreateModelCC, 7
(CC7 8
)CC8 9
;CC9 :
}DD 
)DD 
;DD 
}EE 
catchFF 
(FF 
	ExceptionFF 
exFF 
)FF  
{GG 
_loggerHH 
.HH 
LogErrorHH  
(HH  !
-HH! "
$numHH" #
,HH# $
exHH% '
,HH' (
$strHH) R
)HHR S
;HHS T
}II 
}JJ 	
publicLL 
voidLL 
PublishLL 
(LL 
IntegrationEventLL ,
@eventLL- 3
)LL3 4
{MM 	

TryConnectNN 
(NN 
)NN 
;NN 
varPP 
policyPP 
=PP 
PolicyPP 
.PP  
HandlePP  &
<PP& '&
BrokerUnreachableExceptionPP' A
>PPA B
(PPB C
)PPC D
.QQ 
OrQQ 
<QQ 
SocketExceptionQQ #
>QQ# $
(QQ$ %
)QQ% &
.RR 
WaitAndRetryRR 
(RR 
_retryCountRR )
,RR) *
retryAttemptRR+ 7
=>RR8 :
TimeSpanRR; C
.RRC D
FromSecondsRRD O
(RRO P
MathRRP T
.RRT U
PowRRU X
(RRX Y
$numRRY Z
,RRZ [
retryAttemptRR\ h
)RRh i
)RRi j
,RRj k
(RRl m
exRRm o
,RRo p
timeRRq u
)RRu v
=>RRw y
{SS 
_loggerTT 
.TT 

LogWarningTT &
(TT& '
exTT' )
,TT) *
$strTT+ x
,TTx y
@event	TTz �
.
TT� �
Id
TT� �
,
TT� �
$"
TT� �
{
TT� �
time
TT� �
.
TT� �
TotalSeconds
TT� �
:
TT� �
$str
TT� �
}
TT� �
"
TT� �
,
TT� �
ex
TT� �
.
TT� �
Message
TT� �
)
TT� �
;
TT� �
}UU 
)UU 
;UU 
varWW 
	eventNameWW 
=WW 
@eventWW "
.WW" #
GetTypeWW# *
(WW* +
)WW+ ,
.WW, -
NameWW- 1
;WW1 2
varYY 
bodyYY 
=YY 
JsonSerializerYY %
.YY% & 
SerializeToUtf8BytesYY& :
(YY: ;
@eventYY; A
,YYA B
@eventYYC I
.YYI J
GetTypeYYJ Q
(YYQ R
)YYR S
,YYS T
newYYU X!
JsonSerializerOptionsYYY n
{ZZ 

=[[ 
true[[  $
}\\ 
)\\
;\\ 
policy^^ 
.^^ 
Execute^^ 
(^^ 
(^^ 
)^^ 
=>^^  
{__ 
_logger`` 
.`` 
LogTrace``  
(``  !
$str``! E
,``E F
@event``G M
.``M N
Id``N P
)``P Q
;``Q R
_channelbb 
.bb 
BasicPublishbb %
(bb% &
exchangecc 
:cc 
$strcc  
,cc  !

routingKeydd 
:dd 
	eventNamedd  )
,dd) *
basicPropertiesee #
:ee# $
nullee% )
,ee) *
bodyff 
:ff 
bodyff 
)ff 
;ff  
}gg 
)gg
;gg 
}hh 	
publicjj 
voidjj 
	Subscribejj 
<jj 
TRequestjj &
,jj& '
	TResponsejj( 1
>jj1 2
(jj2 3
)jj3 4
wherekk 
TRequestkk 
:kk 
IntegrationEventkk -
wherell 
	TResponsell 
:ll 
ResponseMessagell -
{mm 	
throw
�� 
new
�� %
NotImplementedException
�� -
(
��- .
)
��. /
;
��/ 0
}
�� 	
public
�� 
void
�� 
Dispose
�� 
(
�� 
)
�� 
{
�� 	
_channel
�� 
?
�� 
.
�� 
Close
�� 
(
�� 
)
�� 
;
�� 
_connection
�� 
?
�� 
.
�� 
Close
�� 
(
�� 
)
��  
;
��  !
_channel
�� 
?
�� 
.
�� 
Dispose
�� 
(
�� 
)
�� 
;
��  
_connection
�� 
?
�� 
.
�� 
Dispose
��  
(
��  !
)
��! "
;
��" #
}
�� 	
}
�� 
}�� 