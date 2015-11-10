function x = readflat(filename,showheader)
%READFLAT Read flat text file with header.
%   READFLAT(FILENAME) returns the data in FILENAME ignoring any
%   non-numeric header lines (which are displayed on the screen).
%   The data will be returned in a matrix where the number of
%   columns is equal to the number of items in the first non-
%   header line of the file.  The matrix is padded with zeros if
%   necessary.
%
%   READFLAT(FILENAME,SHOWHEADER) displays the header if SHOWHEADER
%   is non-zero and supresses it otherwise.
%
%   If FILENAME is omitted, the user will be prompted for a file.

%   written by Douglas M. Schwarz
%   schwarz@kodak.com
%   25 October 1994
%   last modified: 4 March 1998

if nargin == 1,
    if isstr(filename),
        showheader = 1;
    else
        showheader = filename;
        [filename,directory] = uigetfile('','Select a flat text file:');
        filename = [directory,filename];
    end
elseif nargin == 0,
    showheader = 1;
    [filename,directory] = uigetfile('','Select a flat text file:');
    filename = [directory,filename];
end

fid = fopen(filename);
count = 0;

% Look for first non-header line
while count == 0,
    pos = ftell(fid);
    line = fgetl(fid);
    if ~isempty(line) & line == -1,
        fclose(fid);
        error('No numeric data found.')
    end
    [data,count] = sscanf(line,'%f');
    if showheader & ~count,
        disp(line)
    end
end

% Point to beginning of data and read into matrix
fseek(fid,pos,'bof');
x = fscanf(fid,'%f',[count,inf])';
fclose(fid);
