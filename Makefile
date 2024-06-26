M80PATH=D:/M80
PORT=COM5

.SUFFIXES: .ASM .REL .BIN

.ASM.REL:
	M80 '=$< /I/L'

clean:
	del *.REL
	del *.PRN
	del *.BIN

all: Date.rkl

send: Date.rkl
	MODE $(PORT): baud=115200 parity=N data=8 stop=1
	cmd /C copy /B  $< $(PORT)

Date.COM: Date.REL
	$(M80PATH)/L80 /P:100,$<,$@/N/E
	../m80noi/x64/Release/m80noi.exe Date.PRN

Date.rkl: Date.COM
	../makerk/Release/makerk.exe 100 $< $@
