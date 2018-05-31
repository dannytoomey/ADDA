%loop to be used to create data files for different subjects
%aDT(n) = n task, tTD(n) = 50/100% cue validity, tCD(n) = block, tBT = 8
%every time because (8).thisTrialData has the complete trial data

function stroopAL2(sjNum)

load('dataInfo.mat');
load(stroopLoad);

for task=1:numTask
    for cue=1:numCue
        if taskOrder==1
            if task==1
                taskCond=1;
            elseif task==2
                taskCond=2;
            end
        elseif taskOrder==2
            if task==1
                taskCond=1;
            elseif task==2
                taskCond=2;
            end
        elseif taskOrder==3
            if task==1
                taskCond=1;
            elseif task==2
                taskCond=2;
            end
        elseif taskOrder==4
            if task==1
                taskCond=2;
            elseif task==2
                taskCond=1;
            end
        elseif taskOrder==5
            if task==1
                taskCond=2;
            elseif task==2
                taskCond=1;
            end
        elseif taskOrder==6
            if task==1
                taskCond=2;
            elseif task==2
                taskCond=1;
            end
        end
        block1=allStroopTask(task).thisTaskData(cue).thisCondData(1).thisBlockTrials(8).thisTrialData;
        block2=allStroopTask(task).thisTaskData(cue).thisCondData(2).thisBlockTrials(8).thisTrialData;
        block3=allStroopTask(task).thisTaskData(cue).thisCondData(3).thisBlockTrials(8).thisTrialData;
        block4=allStroopTask(task).thisTaskData(cue).thisCondData(4).thisBlockTrials(8).thisTrialData;
        block5=allStroopTask(task).thisTaskData(cue).thisCondData(5).thisBlockTrials(8).thisTrialData;
        block6=allStroopTask(task).thisTaskData(cue).thisCondData(6).thisBlockTrials(8).thisTrialData;
        block7=allStroopTask(task).thisTaskData(cue).thisCondData(7).thisBlockTrials(8).thisTrialData;
        block8=allStroopTask(task).thisTaskData(cue).thisCondData(8).thisBlockTrials(8).thisTrialData;
        data = [block1,block2,block3,block4,block5,block6,block7,block8];
        blockWM=allStroopTask(task).thisTaskData(cue).thisCondData(8).thisblockWM;
        blockWMload=blockWM(1:5,:);
        blockWMprobe=blockWM(6:10,:);
        trials = size(data,2);
        %determine if cueCond==1 or 2
        if data(5,1)==1
            cueCond=1;
        elseif data(5,1)==2
            cueCond=2;
        end
        
        %determine blockID
        if taskCond==1
            if cueCond==1
                blockID = 'strsi50';
            elseif cueCond==2
                blockID = 'strsi100';
            end
        elseif taskCond==2
            if cueCond==1
                blockID = 'strdu50';
            elseif cueCond==2
                blockID = 'strdu100';
            end
        end
        
        errorCom = 0;
        errorOm = 0;
        oriEf = 0;
        
        if taskCond==1
            resp = find(data(9,:)>0);
            numResp = numel(resp);
            errorOm = trials-numResp;
            rt = zeros(1,trials-errorOm);
            %get RT for resp trials
            for count=1:trials-errorOm
                rt(1,count)=data(10,resp(1,count));
            end
            %get accuracy
            ac = zeros(1,trials-errorOm);
            if cueCond==1
                for count=1:trials-errorOm
                    if data(9,resp(1,count))==1
                        if data(6,resp(1,count))<=50
                            ac(1,count)=1;
                        end
                    elseif data(9,resp(1,count))==2
                        if data(6,resp(1,count))<50
                            ac(1,count)=1;
                        end
                    end
                end
            end
            if cueCond==2
                for count=1:trials-errorOm
                    if data(9,resp(1,count))==1
                        if data(7,resp(1,count))<600
                            ac(1,count)=1;
                        end
                    elseif data(9,resp(1,count))==2
                        if data(7,resp(1,count))<600
                            ac(1,count)=1;
                        end
                    end
                end
            end


            correct = find(ac==1);
            numCorrect = numel(correct);
            accuracy = numCorrect/trials;
            meanRT = mean(rt);
            
        end
        if taskCond==2
            errorCom = 0;
            errorOm = 0;
            for count=1:trials
                if data(8,count)==600
                    if data(9,count)>0
                        errorCom=errorCom+1;
                    end
                elseif data(8,count)==300
                    if data(9,count)==0
                        errorOm=errorOm+1;
                    end
                end
            end
            lowToneResp=find(data(8,:)==300&data(9,:)~=0);
            highToneResp=find(data(8,:)==600);
            numResp=numel(lowToneResp)+numel(highToneResp);
            sortResps=[lowToneResp,highToneResp];
            resps=sort(sortResps);
            rt=zeros(1,numel(lowToneResp));
            for count=1:numel(lowToneResp)
                if data(9,lowToneResp(1,count))~=0
                    rt(1,count)=data(10,lowToneResp(1,count));
                end
            end
            ac = zeros(1,numResp);
            for count=1:numResp
                if data(8,resps(1,count))==300
                    if data(5,resps(1,count))==1
                        if data(6,resps(1,count))<=50
                            if data(9,resps(1,count))==1
                                ac(1,count)=1;
                            end
                        elseif data(6,resps(1,count))>50
                            if data(9,resps(1,count))==2
                                ac(1,count)=1;
                            end
                        end
                    end
                    if data(5,resps(1,count))==2
                        if data(7,resps(1,count))<600
                            if data(9,resps(1,count))==1
                                ac(1,count)=1;
                            end
                        elseif data(6,resps(1,count))>600
                            if data(9,resps(1,count))==2
                                ac(1,count)=1;
                            end
                        end
                    end
                elseif data(6,resps(1,count))==600
                    if data(7,resps(1,count))==0
                        ac(1,count)=1;
                    end
                end
            end
            
            correct = find(ac==1);
            numCorrect = numel(correct);
            accuracy = numCorrect/trials;
            meanRT = mean(rt);
            
        end
        
        %determine WMC

        WMorder=zeros(size(blockWMload,1),size(blockWM,2));
        for block=1:size(blockWM,2)
            for letter=1:size(blockWMload,1)
                if blockWMload(letter,block)==blockWMprobe(letter,block)
                    WMorder(letter,block)=1;
                end
            end
        end
        
        acWMorder=numel(find(WMorder==1))/numel(WMorder);
        meanWMletter=zeros(1,size(blockWM,2));
       
        for block=1:size(blockWM,2)
            letterInLoad=0;
            thisBlockWM=blockWMload(:,block);
            for letter=1:size(blockWMload,1)
                resp=find(blockWMprobe(letter,block)==thisBlockWM);
                if resp~=0
                    letterInLoad=letterInLoad+1;
                end
                acLetter=letterInLoad/size(blockWMload,1);
            end
            meanWMletter(1,block)=acLetter;
        end
        
        acWMletter=sum(meanWMletter)/numel(meanWMletter);
        
        %find orienting effect
        
        numValid=0;
        numInvalid=0;
        valTrials=zeros(1,trials);
        invalTrials=zeros(1,trials);
        if cueCond==1
            for count=1:trials
                if data(7,count)<600&&data(6,count)<=50
                    numValid=numValid+1;
                    valTrials(1,count)=data(10,count);
                elseif 600<data(7,count)&&50<data(6,count)
                    numValid=numValid+1;
                    valTrials(1,count)=data(10,count);
                elseif data(7,count)<600&&50<data(6,count)
                    numInvalid=numInvalid+1;
                    invalTrials(1,count)=data(10,count);
                elseif 600<data(7,count)&&data(5,count)<=50
                    numInvalid=numInvalid+1;
                    invalTrials(1,count)=data(10,count);
                end
            end
            valTrialsRT=sum(valTrials)/sum(valTrials~=0,2);
            invalTrialsRT=sum(invalTrials)/sum(invalTrials~=0,2);
            oriEf=invalTrialsRT-valTrialsRT;
        end
            
        save([filePath '/' sprintf('sj%02d_%s.mat',sjNum,blockID)],'trials','errorCom','errorOm','numCorrect','accuracy','meanRT','acWMorder','acWMletter','oriEf');
        
    end
end

    
return
