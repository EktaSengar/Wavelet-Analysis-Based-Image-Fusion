function [LHf]=fusion_LH(LH,LH1,HL,HL1,HH,HH1)
[s,d]=size(LH);
if (all(all(LH))==0 && all(all(HL))==0 && all(all(HH))==0)
    LHf=LH1;
elseif (all(all(LH1))==0 && all(all(HL1))==0 && all(all(HH1))==0)
    LHf=LH;
elseif (all(all(LH))==0 && all(all(LH1))==0)
    LHf=LH1;
elseif (all(all(HL))==0 && all(all(HL1))==0)
    LHf=LH1;
elseif (all(all(HH))==0 && all(all(HH1))==0)
    LHf=LH1;
else
    
%calculating energy
e_LH1=(sum(sum(LH1.^2)))/(s*d);
e_LH=(sum(sum(LH.^2)))/(s*d);
e_HL=(sum(sum(HL.^2)))/(s*d);
e_HL1=(sum(sum(HL1.^2)))/(s*d);
e_HH=(sum(sum(HH.^2)))/(s*d);
e_HH1=(sum(sum(HH1.^2)))/(s*d);

%calculating entropy
en_LH=entropy(LH);
en_LH1=entropy(LH1);
en_HL=entropy(HL);
en_HL1=entropy(HL1);
en_HH=entropy(HH);
en_HH1=entropy(HH1);

a=(e_LH)/(e_LH+e_LH1);
b=(e_LH1)/(e_LH+e_LH1);

KHhc = en_LH/(en_LH+en_HL+en_HH);
KHvc = en_HL/(en_LH+en_HL+en_HH);
KHdc = en_HH/(en_LH+en_HL+en_HH);

KHhm = en_LH1/(en_LH1+en_HL1+en_HH1);
KHvm = en_HL1/(en_LH1+en_HL1+en_HH1);
KHdm = en_HH1/(en_LH1+en_HL1+en_HH1);

u=KHhc/(KHhc+KHhm);
v=KHhm/(KHhm+KHhc);

 
%fusion rule 
%LH
if (e_LH>=e_LH1 && KHhc>=KHhm)
    LHf=LH;
elseif (e_LH<e_LH1 && KHhc<KHhm)
    LHf=LH1;
else 
    LHf=(a*LH+b*LH1+u*LH+v*LH1)/2;
end
end 
end




    