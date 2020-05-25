function net=loadNet
[file,path]=uigetfile('*.mat','Select Network');
load(fullfile(path,file));
end