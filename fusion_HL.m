function [HLf]=fusion_HL(LH,LH1,HL,HL1,HH,HH1)
[s,d]=size(LH);
if (all(all(LH))==0 && all(all(HL))==0 && all(all(HH))==0)
    HLf=HL1;
elseif (all(all(LH1))==0 && all(all(HL1))==0 && all(all(HH1))==0)
    HLf=HL;
elseif (all(all(LH))==0 && all(all(LH1))==0)
    HLf=HL1;
elseif (all(all(HL))==0 && all(all(HL1))==0)
    HLf=HL1;
elseif (all(all(HH))==0 && all(all(HH1))==0)
    HLf=HL1;
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

%HL
a1=(e_HL)/((e_HL+e_HL1));
b1=(e_HL1)/((e_HL+e_HL1));
u1=KHvc/(KHvc+KHvm);
v1=KHvm/(KHvm+KHvc);

%fusion rule
if (e_HL>=e_HL1 && KHvc>=KHvm)
    HLf=HL;
elseif (e_HL<e_HL1 && KHvc<KHvm)
    HLf=HL1;
else 
    HLf=(a1*HL+b1*HL1+u1*HL+v1*HL1)/2;
end
end
end




    