function key = MakeKeypoint(pix, xyScale, tScale, x, y, z)
    k.x = x;
    k.y = y;
    k.z = z;
    k.xyScale = xyScale;
    k.tScale = tScale;
    key = MakeKeypointSample(k, pix);
    return;
end


function key = MakeKeypointSample(key, pix)

LoadParams;

MaxIndexVal = 0.2;
changed = 0;

vec = KeySampleVec(key, pix);
VecLength = length(vec);

vec = NormalizeVec(vec, VecLength);

for i = 1:VecLength
    if (vec(i) > MaxIndexVal)
        vec(i) = MaxIndexVal;
        changed = 1;
    end
end
if (changed)
    vec = NormalizeVec(vec, VecLength);
end

for i = 1:VecLength
    intval = int16(512.0 * vec(i));
    if ~(intval >= 0)
        disp('Assertation failed in MakeKeypoint.m');
    end
    key.ivec(i) = uint8(min(255, intval));
end
end


