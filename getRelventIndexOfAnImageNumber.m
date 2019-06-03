function outIndex = getRelventIndexOfAnImageNumber(inIndex)

if(inIndex < 24)
    outIndex = inIndex*11;
    return;
end
if(inIndex < 41)
    outIndex = max(24*11,inIndex*9);
    return;
end
if(inIndex<55)
    outIndex = max(41*9,inIndex*7.6);
    return;
end
if(inIndex<60)
    outIndex = inIndex*8.3;
    return;
end
if(inIndex<63)
    outIndex = inIndex*9.5;
    return;
end
if(inIndex<65)
    outIndex = inIndex*11;
    return;
end
 outIndex = inIndex*12;


end

