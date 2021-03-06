OUT_ZIP=Arch.zip
LNCR_EXE=Arch.exe

DLR=curl
DLR_FLAGS=-L
BASE_URL=https://github.com/yuk7/ArchWSL-FS/releases/download/20101600/rootfs.tar.gz
LNCR_ZIP_URL=https://github.com/yuk7/wsldl/releases/download/20100500/icons.zip
LNCR_ZIP_EXE=Arch.exe

all: $(OUT_ZIP)

zip: $(OUT_ZIP)
$(OUT_ZIP): ziproot
	@echo -e '\e[1;31mBuilding $(OUT_ZIP)\e[m'
	cd ziproot; bsdtar -a -cf ../$(OUT_ZIP) *

ziproot: Launcher.exe rootfs.tar.gz
	@echo -e '\e[1;31mBuilding ziproot...\e[m'
	mkdir ziproot
	cp Launcher.exe ziproot/${LNCR_EXE}
	cp rootfs.tar.gz ziproot/

exe: Launcher.exe
Launcher.exe: icons.zip
	@echo -e '\e[1;31mExtracting Launcher.exe...\e[m'
	bsdtar -xvf icons.zip $(LNCR_ZIP_EXE)
	mv $(LNCR_ZIP_EXE) Launcher.exe

icons.zip:
	@echo -e '\e[1;31mDownloading icons.zip...\e[m'
	$(DLR) $(DLR_FLAGS) $(LNCR_ZIP_URL) -o icons.zip

rootfs.tar.gz:
	@echo -e '\e[1;31mDownloading rootfs.tar.gz...\e[m'
	$(DLR) $(DLR_FLAGS) $(BASE_URL) -o rootfs.tar.gz

clean:
	@echo -e '\e[1;31mCleaning files...\e[m'
	-rm ${OUT_ZIP}
	-rm -r ziproot
	-rm Launcher.exe
	-rm icons.zip
	-rm rootfs.tar.gz
