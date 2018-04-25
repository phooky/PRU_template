If you're using a PocketBone with debian 9.3 (kernel 4.9.82-ti-r102), you'll
find that devicetree overlays aren't working properly and the PRUs are 
inaccessible through remoteproc. I've rebuilt the pocketbone DTS to correct
this; simply copy the prebuilt file to the /boot/dts/(ver)/ directory on your
pocketbeagle, like so:
```
sudo cp am335x-pocketbeagle.dtb /boot/dtbs/4.9.82-ti-r102/
```

