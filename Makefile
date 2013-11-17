LOVEWIN32PATH=/home/michcioperz/Pobrane/love-0.8.0-win-x86
LOVEWIN64PATH=/home/michcioperz/Pobrane/love-0.8.0-win-x64

all: love winpack

love:
	zip -9 -T SimDare.love *.lua *.png *.ogg

winpack: win32pack win64pack

winbin: win32bin win64bin

win32bin: love
	cat $(LOVEWIN32PATH)/love.exe SimDare.love > SimDare32.exe

win64bin: love
	cat $(LOVEWIN64PATH)/love.exe SimDare.love > SimDare64.exe

win32pack: win32bin
	zip -9 -T SimDare32.zip SimDare32.exe $(LOVEWIN32PATH)/SDL.dll $(LOVEWIN32PATH)/OpenAL32.dll $(LOVEWIN64PATH)/license.txt $(LOVEWIN64PATH)/DevIL.dll

win64pack: win64bin
	zip -9 -T SimDare64.zip SimDare64.exe $(LOVEWIN64PATH)/SDL.dll $(LOVEWIN64PATH)/OpenAL32.dll $(LOVEWIN64PATH)/license.txt $(LOVEWIN64PATH)/DevIL.dll

clean:
	rm -f SimDare.love SimDare32.exe SimDare64.exe SimDare32.zip SimDare64.zip
