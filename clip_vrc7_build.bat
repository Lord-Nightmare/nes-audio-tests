REM remove temporary stuff
del build\swap.o
del build\clip_vrc7.o
del build\clip_vrc7.nes
del build\clip_vrc7_nrom.nes
del build\clip_vrc7.nsf
del build\clip_vrc7.dbg
del build\clip_vrc7.map.txt

cc65\bin\ca65 swap.s -o build\swap.o -g
@IF ERRORLEVEL 1 GOTO badbuild

cc65\bin\ca65 clip_vrc7.s -o build\clip_vrc7.o -g
@IF ERRORLEVEL 1 GOTO badbuild

cc65\bin\ld65 -o build\clip_vrc7.nes      -C swap_nes.cfg build\swap.o build\clip_vrc7.o -D INES_MAPPER=85 -m build\clip_vrc7.map.txt --dbgfile build\clip_vrc7.dbg
@IF ERRORLEVEL 1 GOTO badbuild

cc65\bin\ld65 -o build\clip_vrc7_nrom.nes -C swap_nes.cfg build\swap.o build\clip_vrc7.o
@IF ERRORLEVEL 1 GOTO badbuild

cc65\bin\ld65 -o build\clip_vrc7.nsf      -C swap_nsf.cfg build\swap.o build\clip_vrc7.o
@IF ERRORLEVEL 1 GOTO badbuild

@echo.
@echo.
@echo Build complete and successful!
@IF NOT "%1"=="" GOTO endbuild
@pause
@GOTO endbuild

:badbuild
@echo.
@echo.
@echo Build error!
@IF NOT "%1"=="" GOTO endbuild
@pause
:endbuild
