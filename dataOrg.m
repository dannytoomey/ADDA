
%organize data and make it presentable

function dataOrg

sjNum = input('Input subject number ');
filePath = ['/Users/dannytoomey/Documents/Research/ADTask/ADTaskPilot/data/sj' sprintf('%d',sjNum)];
numVis=3;
numTask=2;
numCue=2;

load('dataStruct.mat');

for vis=1:numVis
    if vis==1
        visCond='dot';
    elseif vis==2
        visCond='neu';
    elseif vis==3
        visCond='str';
    end
    for task=1:numTask
        if task==1
            taskCond='si';
        elseif task==2
            taskCond='du';
        end
        for cue=1:numCue
            if cue==1
                cueCond='50';
            elseif cue==2
                cueCond='100';
            end
            
            file=['sj' sprintf('%d',sjNum) '_' sprintf('%s',visCond) sprintf('%s',taskCond) sprintf('%s',cueCond) '.mat'];
            fileLoad=['' sprintf('%s', filePath) '/' sprintf('%s',file)];
            load(fileLoad);
            
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).trials=trials;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).errorCom=errorCom;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).errorOm=errorOm;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).oriEf=oriEf;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).numCorrect=numCorrect;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).accuracy=accuracy;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).meanRT=meanRT;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).acWMorder=acWMorder;
            dataStruct.visCond(vis).taskCond(task).cueCond(cue).thisSj(sjNum).acWMletter=acWMletter;
            
        end
    end
end

save('dataStruct.mat','dataStruct');

return

