data = readtable('adult_data');

data.workclass = categorical(data.workclass);
data.education = categorical(data.education);
data.marital_status = categorical(data.marital_status);
data.occupation = categorical(data.occupation);
data.relationship = categorical(data.relationship);
data.race = categorical(data.race);
data.sex = categorical(data.sex);
data.native_country = categorical(data.native_country);
data.label = categorical(data.label);