
import ctypes



def hide_console_window():
    """
    This function will hide the console, and also provide two .bat: one is for display the console, one is for hide it
    *AUTHOR* xing.gao@nokia.com
    """
    whnd = ctypes.windll.kernel32.GetConsoleWindow()
    bat_path = r'd:\\'
    if whnd != 0:
        ctypes.windll.user32.ShowWindow(whnd, 0)
        with open('%s\\console_display.bat'%bat_path, 'wb') as infile:
            infile.write('python -c "import ctypes; ctypes.windll.user32.ShowWindow(%d, 1)"' % whnd)
        with open('%s\\console_hide.bat'%bat_path, 'wb') as infile:
            infile.write('python -c "import ctypes; ctypes.windll.user32.ShowWindow(%d, 0)"' % whnd)
        ctypes.windll.kernel32.CloseHandle(whnd)


if __name__ == '__main__':
    hide_console_window()
