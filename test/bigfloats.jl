# use BigFloats to determine the correct multipart significand values

setprecision(BigFloat, 1280-32)

if VERSION < v"0.7.0-"
    function randbf(n::Int, minpow2::Int=-30, maxpow2::Int=30)
        map(BigFloat, [
  "1.07667362842634302875882485034815716810629194710565656562969414207416239876804138664200409610113371132280829829629832263256714528995802234040849813704082672156927957863749387076287840301964688430754091065235913161629140290884101760484736726473976079401401147883477923675027520351735075797152855836416e+07",
  "7.60748557393455339828540112453332418619638860305803783802730707022859084587294339903810351152073795054157487281375223707799628501192534101282529017424792511150868032222132483546842951599762092688574875921051939584637424674000900494888159449760594598774242024183935370025516955967800612807273226203056e+03",
 "1.01009783883214796939239044340748787035775744586468925658997362182283343256995923331447855073801654281923815059649089988442055669719130377931811669893494753785172259260668401827608830443258153559955378038315877091487515417840929051078749844294237197559146430830186543200881912955210567697159734161746e+08",
 "4.1245214426363132106952925327575152946135655968460257705895100313409437154706034721072332923408364147795689183110749245398246334615815545526637837203883552374655798754154685643020718698704988357219715592219001016139798058056217494048704150413911515348170194880658304635415197358315798372069765192874e-08" ,
 "1.36992681634497157710823757218212462020923420764304266195733632579164888111419245630311779279748305397282610606960088714843091998438863291788182556221333846649556649520326334458000186369228808757627428735457286282838275315266930380123121254688334794848348755290800846374821276652967840753347718635029e-01",
 "2.94858317848686133293541130602062359010070703806418479610839760302786976368324411900869196286003468069815366567021751663397576055163808821822822097711517381468473106784563064985606637230351326570627909216412824526296346290474319021779700377267907116012148016739873785794441273223196937356937973298659e+02",
 "5.95055797578493207515924145850964017684622369150554788389091946765998252814685042346088932099000365451928691359946290283888488224325538350111090826576924308172152944045983054525124209794731824676188705811652720593410165071875328719162103666763195568281097309793543738523335250616935076596622638347407e+03",
 "3.15054948211191356314913169340959072089219610008297916033091017761704445253825251502165172463341604996908310454459355144649818087578185104293609662661839457745607545427806251391024523966288380842934561506016775114907752505720033212254076073607340345519878814733638203885238055887611157301459041318178e-05",
 "5.77174439114390945273223780323544620768413138937749434744711987997569297056682895255977202079242364047162306732488881077734196226219633554035583634986289034666025443917870332034794257064486275571281320317507018965620420900645995060677533252133506595149704703780132544755752158806504979663672033758911e-04",
 "4.25077457651057377879234217343886357354756446406779144818039083060523697061489328310373443441491281048311726114644057659947258050134289901253358963322154534095999369474744143070279038366242112550530139824644617376434795666898486123044574657401741178206605053191495847432137431639158207948239741121763e-07",
 "1.55682034004501874420112164333526085835012389073718535377079595939390816942886016384758068266677734217122812533071474821647671109235784675493592896971362614284072642114295321294088531594288947767273292078177131845531557139280374027532884522406602667434847367669450902383906530030725605802346291757329e+04",
 "1.14813889416809952394952796336233935453039197815740472314590980781511494565162088199218683863701886151913585902440224716610351397944534001776642148933018925885943822294877766583906263567114594697876001150704382796054810214591847356712635386930139623431463531365908887564165299926472475458986694936992"    ,
 "1.09736700932017264891502504112916215884978496395147385378024211548209007879430197010449264738980720175433779837070866624585059512848665987861336438350266374066628713795624485874888516535689087707302657229083418647724760413522167159656620818880631162538127686367509190385195187904208733155733917198565e+01",
 "4.73456459274572569812070971230583369816815626277683307633994713202237481923273540676481031080298232805624099440914043825555011082176793145710677507438923792398697743761679419998731749761221257578904492581543137680577929159687872144076997699538721156806148086106579722001805270108584960594025581846152e-01",
 "6.74968482387614057550330826710477012042628707503997951014418292047670613959235449126623600309141233050914872706417075420240044574773500648039320707780236936126504702480341633353248328084487055334556920416593820697678075832526726443921438576709327325827313454783411276976602317623583743430806741116158e-07",
 "3.21791225864409900109924218062718769949404895765446161061667938870057501681046915676247941906034526745941307181121408292398527357985090726690049720310000127458829866199757280416321334786265833264976108938476321783958201575418485860696556727064916445558253027138906003513871617900705218919073889971882e-08"
  ])
    end
else                
    function randbf(n::Int, minpow2::Int=-30, maxpow2::Int=30)
        pow2s = rand(minpow2:maxpow2, n)
        bfs = rand(BigFloat, n)
        bfls = [ldexp(frexp(bfs[i])[1], pow2s[i]) for i=1:n]
        return bfls
    end
end

randfl(::Type{T}, n::Int, minpow2::Int=-30, maxpow2::Int=30)  where {T<:AbstractFloat} =
    map(T, randbf(n, minpow2, maxpow2))   


const Floats1 = NTuple{1,T} where {T<:AbstractFloat}
const Floats2 = NTuple{2,T} where {T<:AbstractFloat}
const Floats3 = NTuple{3,T} where {T<:AbstractFloat}
const Floats4 = NTuple{4,T} where {T<:AbstractFloat}
const Floats5 = NTuple{5,T} where {T<:AbstractFloat}
const Floats6 = NTuple{6,T} where {T<:AbstractFloat}
const Floats7 = NTuple{7,T} where {T<:AbstractFloat}
const Floats8 = NTuple{8,T} where {T<:AbstractFloat}
const Floats9 = NTuple{9,T} where {T<:AbstractFloat}


function Floats1(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   return (fl1, )
end

function Floats2(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   return fl1, fl2
end

function Floats3(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   return fl1, fl2, fl3
end

function Floats4(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   fl4 = T(bf - fl1 - fl2 - fl3)
   return fl1, fl2, fl3, fl4
end

function Floats5(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   fl4 = T(bf - fl1 - fl2 - fl3)
   fl5 = T(bf - fl1 - fl2 - fl3 - fl4)
   return fl1, fl2, fl3, fl4, fl5
end

function Floats6(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   fl4 = T(bf - fl1 - fl2 - fl3)
   fl5 = T(bf - fl1 - fl2 - fl3 - fl4)
   fl6 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5)
   return fl1, fl2, fl3, fl4, fl5, fl6
end

function Floats7(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   fl4 = T(bf - fl1 - fl2 - fl3)
   fl5 = T(bf - fl1 - fl2 - fl3 - fl4)
   fl6 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5)
   fl7 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5 - fl6)
   return fl1, fl2, fl3, fl4, fl5, fl6, fl7
end

function Floats8(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   fl4 = T(bf - fl1 - fl2 - fl3)
   fl5 = T(bf - fl1 - fl2 - fl3 - fl4)
   fl6 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5)
   fl7 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5 - fl6)
   fl8 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5 - fl6 - fl7)
   return fl1, fl2, fl3, fl4, fl5, fl6, fl7, fl8
end

function Floats9(::Type{T}, bf::BigFloat) where {T<:AbstractFloat}
   fl1 = T(bf)
   fl2 = T(bf - fl1)
   fl3 = T(bf - fl1 - fl2)
   fl4 = T(bf - fl1 - fl2 - fl3)
   fl5 = T(bf - fl1 - fl2 - fl3 - fl4)
   fl6 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5)
   fl7 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5 - fl6)
   fl8 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5 - fl6 - fl7)
   fl9 = T(bf - fl1 - fl2 - fl3 - fl4 - fl5 - fl6 - fl7 - fl8)
   return fl1, fl2, fl3, fl4, fl5, fl6, fl7, fl8, fl9
end
