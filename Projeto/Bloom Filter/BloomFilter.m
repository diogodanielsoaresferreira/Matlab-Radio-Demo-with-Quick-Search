% Diogo Ferreira e Fábio Cunha, 2015
classdef BloomFilter < handle
    % Class BloomFilter has implemented a bloom filter and all of the
    % methods needed.
    % This class is handle to support pass-by-reference semantics (useful
    % for insert method).
    %
    % Input Arguments:
    % BloomFilter(m,n) or
    % BloomFilter(m)
    % m -> Size of filter
    % n -> Number of elements expected to have
    %
    % Properties:
    % numHash -> Number of Hash Functions being used (Given by method optimalK)
    % filter -> Filter of zeros(initially), waiting to be filled with '1'.
    %
    % Methods:
    % 
    % insert(obj, key):
    % Inserts a key in the filter.
    % 
    % isMember(obj, key):
    % Checks if a key belongs to the filter.
    %
    % optimalValue(m, n):
    % Using a tehretical expression, determine how many hash functions we
    % should use.
    % 
    % String2Hash(str, type):
    % Hash Function
    %
    %
    %
    %
    properties
        numHash;
        filter;
        size;
    end
    
    methods(Access=public)
        function obj=BloomFilter(m,n)
            obj.size=0;
            if nargin>=2
                if n<m                              % Number of elements expected cannot be lower than the filter size.
                    n=m*10;
                end
                obj.numHash=obj.optimalK(m,n);
            elseif nargin==1
                obj.numHash=obj.optimalK(m, m*10);
            elseif nargin==0
                m=1e6;
                obj.numHash=obj.optimalK(m,1e7);
            end
            obj.filter=zeros(1,m);
        end
    end
    methods(Static, Access=private)
        function [k] = optimalK(m, n)
            % Returns the optimal number of hash functions given m elements and n
            % positions in the filter
            % From https://en.wikipedia.org/wiki/Bloom_filter
            
            if nargin<2
                return
            end
            k=round(n*log(2)/m);
        end
        function hash=string2hash(str,type)
            % Função retirada de http://www.cse.yorku.ca/~oz/hash.html (Diogo Ferreira)
            % This function generates a hash value from a text string
            %
            % hash=string2hash(str,type);
            %
            % inputs,
            %   str : The text string, or array with text strings.
            % outputs,
            %   hash : The hash value, integer value between 0 and 2^32-1
            %   type : Type of has 'djb2' (default) or 'sdbm'
            %
            % From c-code on : http://www.cse.yorku.ca/~oz/hash.html
            %
            % djb2
            %  this algorithm was first reported by dan bernstein many years ago
            %  in comp.lang.c
            %
            % sdbm
            %  this algorithm was created for sdbm (a public-domain reimplementation of
            %  ndbm) database library. it was found to do well in scrambling bits,
            %  causing better distribution of the keys and fewer splits. it also happens
            %  to be a good general hashing function with good distribution.
            %
            % example,
            %
            %  hash=string2hash('hello world');
            %  disp(hash);
            %
            % Function is written by D.Kroon University of Twente (June 2010)
            
            
            % From string to double array
            str=double(str);
            if(nargin<2), type='djb2'; end
            switch(type)
                case 'djb2'
                    hash = 5381*ones(size(str,1),1);
                    for i=1:size(str,2),
                        hash = mod(hash * 33 + str(:,i), 2^32-1);
                    end
                case 'sdbm'
                    hash = zeros(size(str,1),1);
                    for i=1:size(str,2),
                        hash = mod(hash * 65599 + str(:,i), 2^32-1);
                    end
                otherwise
                    error('string_hash:inputs','unknown type');
            end
        end
    end
    methods(Access=public)
        function [ isM ] = isMember(obj,key)
            
            % Checks if a key belongs to the filter
			
            isM=1;
            for i=1:obj.numHash
                key=[num2str(i) key];
                if obj.filter(1+rem(obj.string2hash(key),length(obj.filter)))==0
                    isM=0;
                    return
                end
            end
            
        end
        function insert(obj,key)
            
			% Inserts key on filter table
			
            if nargin<1
                return
            end
            
            for i=1:obj.numHash
                key=[num2str(i) key];
                obj.filter(1+rem(obj.string2hash(key),length(obj.filter)))=1;
            end
            obj.size=obj.size+1;
            
        end
        
    end
    
end

