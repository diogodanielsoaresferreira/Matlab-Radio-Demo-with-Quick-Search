% Diogo Ferreira e F�bio Cunha, 2015
function [  ] = PlayMusic( dir,sec )
    % Fun��o que toca uma m�sica presente no diret�rio dir
    % durante sec segundos. Caso sec n�o seja introduzido (ou seja negativo, ou maior do que o tempo da m�sica), 
    % ir� tocar a m�sica inteira.
    
    if nargin==1
        sec=-1;
    end
    
    I=SearchPhoto(dir);
    imshow(I);
    
    
    hfr = dsp.AudioFileReader(dir);
    info=audioinfo(dir);
    hplay = dsp.AudioPlayer('SampleRate',info.SampleRate);
    h=waitbar(0,'Aguarde um momento...');
    i=-1;
    lasttoc=0;
    title=info.Title;
    if isempty(info.Title)
        title = pathToName(dir);
    end
    t=tic;
    if nargin<=1
        while ~isDone(hfr) || sec<0
            acttoc=round(toc(t));
            if (acttoc~=lasttoc)
            	i=i+1;
                waitbar(i/info.Duration, h, sprintf('%s\n Tempo decorrido: %d segundos',title, i));
            end
            lasttoc=acttoc;
            audio = step(hfr);
            step(hplay, audio);
        end
        delete.hplay;
    else
        while toc(t)<sec && ~isDone(hfr)
           acttoc=round(toc(t));
            if (acttoc~=lasttoc)
            	i=i+1;
                waitbar(i/sec, h, sprintf('%s\n Tempo decorrido: %d segundos', title, i));
            end
            lasttoc=acttoc;
            audio = step(hfr);
            step(hplay, audio);
        end
    end
    delete(h)
    close

end

