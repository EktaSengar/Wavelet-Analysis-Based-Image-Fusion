function[LLf]=fusion_LL(LL,LL1)
[s,d]=size(LL);

%calculating energy
e_LL=(sum(sum(LL.^2)))/(s*d);
e_LL1=(sum(sum(LL1.^2)))/(s*d);

%fusion rule
if e_LL>e_LL1
    LLf=LL;
else
    LLf=LL1;
end
end