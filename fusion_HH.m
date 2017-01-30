function [HHf]=fusion_HH(LH,LH1,HL,HL1,HH,HH1)
[s,d]=size(LH);
if (all(all(LH))==0 && all(all(HL))==0 && all(all(HH))==0)
    HHf=HH1;
elseif (all(all(LH1))==0 && all(all(HL1))==0 && all(all(HH1))==0)
    HHf=HH;
elseif (all(all(LH))==0 && all(all(LH1))==0)
    HHf=HH1;
elseif (all(all(HL))==0 && all(all(HL1))==0)
    HHf=HH1;
elseif (all(all(HH))==0 && all(all(HH1))==0)
    HHf=HH1;
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

KHhc = en_LH/(en_LH+en_HL+en_HH);
KHhm = en_LH1/(en_LH1+en_HL1+en_HH1);
KHvc = en_HL/(en_LH+en_HL+en_HH);
KHvm = en_HL1/(en_LH1+en_HL1+en_HH1);
KHdc = en_HH/(en_LH+en_HL+en_HH);
KHdm = en_HH1/(en_LH1+en_HL1+en_HH1);


%HH
a2=(e_HH)/(e_HH+e_HH1);
b2=(e_HH1)/(e_HH+e_HH1);
u2=KHdc/(KHdc+KHdm);
v2=KHdm/(KHdm+KHdc);

%fusion rule
if (e_HH>=e_HH1 && KHdc>=KHdm)
    HHf=HH;
elseif (e_HH<e_HH1 && KHdc<KHdm)
    HHf=HH1;
else 
    HHf=(a2*HH+b2*HH1+u2*HH+v2*HH1)/2;
end
end
end


    