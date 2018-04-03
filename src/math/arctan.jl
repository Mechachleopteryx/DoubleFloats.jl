#=
julia-0.7> x=0.5; y=atan(x); z=Double(y); z - (tan(z)-x)*(cos(z)*cos(z))
Double(0.4636476090008061, 2.2698777452961687e-17)

julia-0.7> t=atan(BigFloat(x));thi=Float64(t);tlo=Float64(t-thi);thi,tlo
(0.4636476090008061, 2.2698777452961687e-17)
=#

const k_pio2 = Double(1.5707963267948966, 6.123233995736766e-17)


function atan(x::Double{T,Accuracy}) where {T<:AbstractFloat}
   y = Double{T,Accuracy}(atan(x.hi))
   s, c = sin(y), cos(y)
   t = s/c
   z = y - (t - x)*(square(c)) # z - (tan(x)-x)*(cos(x)^2)
   return z
end

function atan(x::Double{T,Performance}) where {T<:AbstractFloat}
   y = Double{T,Accuracy}(atan(x.hi))
   s, c = sin(y), cos(y)
   t = s/c
   z = y - (t - x)*(square(c)) # z - (tan(x)-x)*(cos(x)^2)
   return z
end

function asin(x::Double{T,E}) where {T<:AbstractFloat, E<:Emphasis}
     xabs = abs(x)
     xabs > 1.0 && throw(DomainError("$x"))
     y = xabs / (1.0 - square(xabs))
     y = atan(y)
     y = copysign(y, x)
     return y
end

function acos(x::Double{T,E}) where {T<:AbstractFloat, E<:Emphasis}
     abs(x) > 1.0 && throw(DomainError("$x"))
     y = (1.0 - square(x)) / x
     y = atan(y)
     return y
end

acsc(x::Double{T,E}) where {T<:AbstractFloat, E<:Emphasis} = asin(inv(x))
asec(x::Double{T,E}) where {T<:AbstractFloat, E<:Emphasis} = acos(inv(x))

function acot(x::Double{T,E}) where {T<:AbstractFloat, E<:Emphasis}
   iszero(x) && return k_pio2
   z = k_pio2 - atan(abs(x))
   if signbit(x.hi)
      z = -z
   end
   return z
end

     
#=
http://mathworld.wolfram.com/InverseTangent.html cites Acton 1990
=#
#=
function atan(x::T) where {T<:AbstractFloat}
    return atan(x)
end

function atan(x::Double{T,Accuracy}) where {T<:AbstractFloat}
    b = one(Double{T,Accuracy})
    a = inv(sqrt(b+square(x)))
    result = x * a
    while abs(a) < abs(b)
        a = (a + b) / 2
        b = sqrt(a * b)
    end

    result = result * inv(a)
    return result
end

function atan(x::Double{T,Performance}) where {T<:AbstractFloat}
    result = arctan(Double{T,Accuracy}(x))
    return Double(Performance, HILO(result))
end
=#
