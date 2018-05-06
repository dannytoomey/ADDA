%data analyis runfile

sjNum = input('Input sjNum ');
file = '/Users/dannytoomey/Documents/Research/ADTask/ADTaskPilot/data/';
fileName = ['sj' sprintf('%d',sjNum)];
filePath = [file sprintf('%s',fileName)];
dotLoad = [sprintf('%s',fileName) '_' 'allDotTask.mat'];
neutralLoad = [sprintf('%s',fileName) '_' 'allNeutralTask.mat'];
stroopLoad = [sprintf('%s',fileName) '_' 'allStroopTask.mat'];

numTask = 2;
numCue = 2;

save('dataInfo','sjNum','numTask','numCue','filePath','fileName','dotLoad','neutralLoad','stroopLoad');

dotAL(sjNum)
neutralAL(sjNum)
stroopAL(sjNum)

