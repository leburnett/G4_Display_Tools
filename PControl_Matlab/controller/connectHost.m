function success = connectHost()

global ctlr;

ctlr = PanelsController();
ctlr.mode = 0;
ctlr.open();

if ctlr.tcpConn == -1
    system('"C:\Program Files (x86)\HHMI G4\G4 Host" &');
    status = 1;
    while status~=0
        [status, ~] = system('tasklist | find /I "G4 Host.exe"');
        pause(0.1);
    end
    ctlr = PanelsController();
    ctlr.mode = 0;
    ctlr.open();
end

%check whether the TCP connection was openned successfully
if ctlr.tcpConn == -1
    if ctlr.mode == 1
        errordlg('Tcp/ip connection is broken. Please check whether the host app is running.', 'Broken TCP/IP connection!');
    else
        cprintf('err', 'Tcp/ip connection is broken. Please check whether the host app is running.\n')
    end
    success = 0;
else
    success = 1;
end

