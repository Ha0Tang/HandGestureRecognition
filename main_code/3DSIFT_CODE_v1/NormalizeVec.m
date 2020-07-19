function vec = NormalizeVec(vec, len)

sqlen = dot(vec,vec);
fac = 1.0 / sqrt(sqlen);
vec = vec .* fac;

end