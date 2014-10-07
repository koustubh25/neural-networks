%IMPLEMENTATION OF ELMAN NEURAL NETWORK BASED INTERNET TRAFFIC PREDICTION

clc
CSV_PATH = 'C:/Users/Koustubh/Dropbox/Keio/Research/Video on cloud/Neural Networks/YoutubeStats/';
CSV_FILE = 'stats_HK_Umbrella_Revolution2.csv';
ROWS = 722;
COLUMNS = 25;


%Read data from CSV

strcat('The CSV has ', num2str(ROWS - 2), ' data sets')
fid = fopen(strcat(CSV_PATH,CSV_FILE));


for i=1:ROWS
    row = textscan(fid,'%s',COLUMNS,'Delimiter',',');
    if i<=2
        continue;
    else
        data{i-2} = row{1} ;   
    end
end



%Creation of Elman Neural Network
%================================

% initialise training set - Input and Output

for i=1:ROWS-2
    
    %output
    concurrent{i} = str2num(data{i}{1});
    
    likes{i} = str2num(data{i}{2});
    adislikes{i} = str2num(data{i}{3});
    
    %Quality section
    qual240p{i} =  ((str2num(data{i}{8})));
    qual360p{i} =  (str2num(data{i}{9}));
    qual720p{i} =  (str2num(data{i}{10}));
    qual1080p{i} =  (str2num(data{i}{11}));
    
    %Device Section
    dev_lapdesk{i} =  (str2num(data{i}{12}));
    dev_android{i} =  (str2num(data{i}{13}));
    dev_iphone{i} =  (str2num(data{i}{14}));
    dev_xbox{i} =  (str2num(data{i}{15}));
    dev_ps{i} =  (str2num(data{i}{16}));
    
    %popularity
    anticipation_or_popularity{i} = str2num(data{i}{17});
    
    %category
    cat_news{i} =  (str2num(data{i}{18}));
    cat_sports{i} =  (str2num(data{i}{19}));
    cat_entertainment{i} =  (str2num(data{i}{20})); 
    
    %Location
    loc_tokyo{i} =  (str2num(data{i}{21}));
    loc_australia{i} =  (str2num(data{i}{22}));
    loc_london{i} =  (str2num(data{i}{23}));
    loc_america{i} =  (str2num(data{i}{24}));
    
    %Not applicable everywhere
    %=========================
    
    %Total Viewers
    
  %  total_views{i} = str2num(data{i}{4});
  %  subs_driven{i} = str2num(data{i}{5});
  %  total_shares{i} = str2num(data{i}{6});
end



%Elman Neural Network
%=====================

% MIN AND MAX VALUES FO EACH INPUT

PR = [ 0 100000; %likes
       0 100000; %dislikes
       0 1;      %240p
       0 1;      %360p
       0 1;      %720p
       0 1;      %1080p
       0 1;      %Laptops/Dekstops
       0 1;     %Android
       0 1;      %iPhone
       0 1;     %Xbox
       0 1;     %Playstation
       0 1;      %Anticipation / popularity
       0 1;      %News
       0 1;      %Sports
       0 1;      %Entertainment
       0 1;      %Tokyo
       0 1;      %Australia
       0 1;      %London
       0 1;      %America
      %If you want do it for source region
    %   0 100000; %Total Viewers
    %   0 100000;  %Subscriptions Driven
    %   0 100000;  %Shares
                ];
            
 
 s = [ 10 10 10 1];    %Change the size of the array and its values to change the number of layers/neurons
 
 for i=1:size(s)
    Transfer_function{i} = 'logsig';
 end
 
 
 
 %Create a Elman Neural Network
 fprintf('inputs is');
 inputs = [
     likes;
     adislikes;
     qual240p;
     qual360p;
     qual720p;
     qual1080p;
     dev_lapdesk;
     dev_android;
     dev_iphone;
     dev_xbox;
     dev_ps;
     anticipation_or_popularity;
     cat_news;
     cat_sports;
     cat_entertainment;
     loc_tokyo;
     loc_australia;
     loc_london;
     loc_america;
     %total_views;
     %subs_driven;
     %total_shares;
     ]
 
    
  %Creating Elman Neural Network
  net = newelm(PR,s, {'purelin',   'purelin','purelin','purelin'});
 
  net.trainParam.lr = 0.000000005;
  net.trainParam.min_grad = 1e-5;
  
  %Train the Elman Neural Network   

  net = train(net,cell2mat(inputs),cell2mat(concurrent));
  

  Y=sim(net,cell2mat(inputs))
 
 