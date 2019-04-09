function [serPort] = RoombaInit(my_COM)
%[serPort] = RoombaInit(my_COM)
%   initializes serial port for use with Roomba
%   COMMport is the number of the comm port 
%   ex. RoombaInit('COM1') sets port = 'COM1' (Windows Machine)
%   note that it sets baudrate to a default of 115200
%   can be changed (see OI).  
%   An optional time delay can be added after all commands
%   if your code crashes frequently.  15 ms is recommended by irobot
%   By Joel Esposito, US Naval Academy, 2011
%
%   Changes by Kevin Denis
%   * Baudrate for Roomba 620
%   * The non very user friendly LED display, just kept the BeepTone
%   * Multiplatform adaptation (Windows and linux)

global td
td = 0.015;

% This code puts the robot in CONTROL(132) mode, which means does NOT stop 
% when cliff sensors or wheel drops are true; can also run while plugged into charger
Start=128;
Control = 130;
Full = 132;

warning off

%% set up serial comms,   
% output buffer must be big enough to take largest message size

a = instrfind('port',my_COM);
if ~isempty(a)
            disp('That com port is in use.   Closing it.')
            fclose(a);
            pause(0.25)
            delete(a);
            pause(0.25)
end
    
disp('Establishing connection to Roomba...');

% defaults at 115200, can change
serPort = serial(my_COM,'BaudRate', 115200);
set(serPort,'Terminator','LF')
set(serPort,'InputBufferSize',100)
set(serPort, 'Timeout', 1)
set(serPort, 'ByteOrder','bigEndian');
set(serPort, 'Parity', 'None')
set(serPort, 'DataBits', 8)
set(serPort, 'Stopbits', 1)
set(serPort, 'Tag', 'Roomba')

disp('Opening connection to Roomba...');
try
    fopen(serPort);
catch me
    disp('open failed')
    return
end

%% Confirm two way connumication
disp('Setting Roomba to Control Mode...');
% Start! and see if its alive
fwrite(serPort,Start);
pause(.1)

fwrite(serPort,Control);
pause(.1)

fwrite(serPort,Full);
pause(.1)

% set song
%[140] [Song Number] [Song Length] [Note Number 1] [Note Duration 1]
fwrite(serPort, [140 1 1 72 20]);
pause(0.05)

% sing it
fwrite(serPort, [141 1])

disp('I am alive if you just heard me beep')

%confirmation = (fread(serPort,4))
pause(.1)