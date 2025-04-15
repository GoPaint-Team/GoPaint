@ echo off
pyinstaller --name gopaint --onefile --icon=icon.png --hidden-import=pyqtribbon --collect-all pyqtribbon gopaint.py