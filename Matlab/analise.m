onze = table2array(dadosOriginais(:,11));
onze_unq = unique(onze);
onze_occ = [onze_unq histc(onze,onze_unq)]

doze = table2array(dadosOriginais(:,12));
doze_unq = unique(doze);
doze_occ = [doze_unq histc(doze,doze_unq)]