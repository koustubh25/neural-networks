%Simply plotting 

clc
clearvars
%CSV_PATH = 'C:/Users/Koustubh/Dropbox/Keio/Research/Video on cloud/Neural Networks/YoutubeStats/';
CSV_PATH='';
CSV_FILE = 'test1.csv';
ROWS = 931;
COLUMNS = 2;
DEVICES = { 'Android', 'iPhone', 'TV', 'Desktop'};
QUALITIES = { '240p','360p','720p','1080p'};
REGIONS = { 'Asia', 'America', 'Europe','Australia'};


%Read data from CSV

strcat('The CSV has ', num2str(ROWS - 2), ' data sets');
fid = fopen(strcat(CSV_PATH,CSV_FILE));


for i=1:ROWS
    row = textscan(fid,'%s',COLUMNS,'Delimiter',',');
    if i<=2
        continue;
    else
        
        data{i-2} = row{1} ;   
    end
end


for i=1:ROWS-2
    %ts{i} = datenum(data{i}{2});
    concurrent_viewers{i} = str2num(data{i}{1});
end

CV = transpose(concurrent_viewers);



A = (1:30:size(CV,1)*30);
subplot(3,1,1);
plot(A,cell2mat(CV));
xlabel('Time Interval(seconds)');
ylabel('Total Number of Viewers');
title('Total Number of viewers for Hong Kong Umbrella Revolution,as seen on Oct 7th - Youtube Live Stream');


%Calculate the Distribution
%==========================

bins=929;

distribution  = hist(cell2mat(CV),bins);

%Plot for Distribution 
subplot(3,2,3);
plot(distribution);
xlabel('bins');
ylabel('Video Traffic');
title('Video Traffic Distribution for Hong Kong Umbrella Revolution');
xlim([0 bins]);

total_distribution = sum(distribution);
distribution(1)
for i=1:1:bins
    generalpdf(i) = distribution(i) / max(distribution);
end

%Plot for Probabilty Density Function
subplot(3,2,4);
bar(generalpdf);
xlabel('bins');
ylabel('Probability');
title('Probability Density Function for Video Traffic');
xlim([0 1000]);

%Define distribution functions
%==============================

%qualities
subplot(3,2,5);
X= 1:1000;
qual240p = gampdf(X,1.5,300);
plot(X,qual240p);
hold on;
qual360p = gampdf(X,1.8,300);
plot(X,qual360p,'--r');
hold on;
qual720p = gampdf(X,2.8,150);
plot(X,qual720p,'-.m');
hold on;
qual1080p = gampdf(X,1.2,200);
plot(X,qual1080p,'-k');
legend('240p','360p','720p','1080p');
ylabel('Probability');
title('Probability Distribution (Gamma) for Video Qualities');

%Devices
subplot(3,2,6);
X= 1:1000;
android = gampdf(X,1.5,300);
plot(X,android);
hold on;
iphone = gampdf(X,1.8,300);
plot(X,iphone,'--r');
hold on;
tv = gampdf(X,2.8,150);
plot(X,tv,'-.m');
hold on;
desktop = gampdf(X,1.2,200);
plot(X,desktop,'-k');
legend('Android','iPhone','TV','Deskop');
ylabel('Probability');
title('Probability Distribution (Gamma) for devices');

figure


%Devices
subplot(2,2,1);
X= 1:1000;
asia = gampdf(X,1.5,300);
plot(X,android);
hold on;
america = gampdf(X,1.8,300);
plot(X,iphone,'--r');
hold on;
europe = gampdf(X,2.8,150);
plot(X,tv,'-.m');
hold on;
desktop = gampdf(X,1.2,200);
plot(X,desktop,'-k');
legend('Asia','America','Europe','Australia');
ylabel('Probability');
title('Probability Distribution (Gamma) for Regions');

%Simply concatenate pdfs for qualities together

pdfsQualities = [qual240p;
    qual360p;
    qual720p;
    qual1080p;
    ];

%Calculate probabilities for wach type of quality

qualProbs = calculateProbabilities(generalpdf,QUALITIES,pdfsQualities);


%Calculate probabilities for each type of device for each type of quality

pdfsDevices = [ android;
    iphone;
    tv;
    desktop];

%Device Probabilities  for various qualities as indicated by the variable
%name

deviceProbs240p = calculateProbabilities(qualProbs(1,:),DEVICES,pdfsDevices);
deviceProbs360p = calculateProbabilities(qualProbs(2,:),DEVICES,pdfsDevices);
deviceProbs720p = calculateProbabilities(qualProbs(3,:),DEVICES,pdfsDevices);
deviceProbs1080p = calculateProbabilities(qualProbs(4,:),DEVICES,pdfsDevices);

%Region Probabilities for each type of device , quality and Region


%Calculate probabilities for each type of device for each type of region

pdfsRegions = [ android;
    iphone;
    tv;
    desktop];

%Region
region240pandroid = calculateProbabilities(deviceProbs240p(1,:),REGIONS,pdfsRegions);
region240piphone = calculateProbabilities(deviceProbs240p(2,:),REGIONS,pdfsRegions);
region240ptv = calculateProbabilities(deviceProbs240p(3,:),REGIONS,pdfsRegions);
region240pdesktop = calculateProbabilities(deviceProbs240p(4,:),REGIONS,pdfsRegions);

region360pandroid = calculateProbabilities(deviceProbs360p(1,:),REGIONS,pdfsRegions);
region360piphone = calculateProbabilities(deviceProbs360p(2,:),REGIONS,pdfsRegions);
region360ptv = calculateProbabilities(deviceProbs360p(3,:),REGIONS,pdfsRegions);
region360pdesktop = calculateProbabilities(deviceProbs360p(4,:),REGIONS,pdfsRegions);

region720pandroid = calculateProbabilities(deviceProbs720p(1,:),REGIONS,pdfsRegions);
region720piphone = calculateProbabilities(deviceProbs720p(2,:),REGIONS,pdfsRegions);
region720ptv = calculateProbabilities(deviceProbs720p(3,:),REGIONS,pdfsRegions);
region720pdesktop = calculateProbabilities(deviceProbs720p(4,:),REGIONS,pdfsRegions);

region1080pandroid = calculateProbabilities(deviceProbs1080p(1,:),REGIONS,pdfsRegions);
region1080piphone = calculateProbabilities(deviceProbs1080p(2,:),REGIONS,pdfsRegions);
region1080ptv = calculateProbabilities(deviceProbs1080p(3,:),REGIONS,pdfsRegions);
region1080pdesktop = calculateProbabilities(deviceProbs1080p(4,:),REGIONS,pdfsRegions);





     