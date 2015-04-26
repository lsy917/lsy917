function [Branches,numBranch]=Net_Branches(ConnectMatrix)



[numNode,I] = size(ConnectMatrix);
if numNode ~= I
    error('Pls check your connect matrix');
end

 
Node = [1:numNode];
Branches = [];
 
while any(Node)
    Quence = find(Node,1);      %find a non-zero number in Node set
    subField=[];                %one component
    % start search
    while ~isempty(Quence)
        currentNode = Quence(1);
        Quence(1) = [];         %dequeue
        subField=[subField,currentNode];
        Node(currentNode)=0;
        neighborNode=find(ConnectMatrix(currentNode,:));
        for i=neighborNode
            if Node(i) ~= 0     %first found
                Quence=[Quence,i];
                Node(i)=0;
            end
        end
    end
    subField = [subField,zeros(1,numNode-length(subField))];
    Branches = [Branches;subField]; %save
end
numBranch = size(Branches,1);
