# Nandland Go Board
This repository tutorial files and projects relating to the [Go Board](https://nandland.com/the-go-board/). Refer to this [link](https://nandland.com/project-1-your-first-go-board-project/) for more information on setting up the deployment process.

### Required software
- [iCEcube2](http://latticesemi.com/Products/DesignSoftwareAndIP/FPGAandLDS/iCEcube2.aspx)
- [Diamond Programmer](https://www.latticesemi.com/Products/DesignSoftwareAndIP/FPGAandLDS/LatticeDiamond)
- [Drivers](https://ftdichip.com/drivers/vcp-drivers/)

### Building Verilog file to FPGA
This is done through Lattice iCEcube2. This converts verilog code to a bitmap. <br>

1. Create `New Project` and ensure:
    - Device Family: iCE40
    - Device: HX1K
    - Device Package: VQ100
    - IOBank Voltage: 3.3V
2. Add verilog files to `Files to add`. Verilog files should be in `Synthesis Tool/Add Synthesis Files/Design Files`.
3. Add constraints file by `P&R Flow/Add P&R Files/Constraint Files`. The file is called `Go_Board_Constraints.pcf`. This file maps inputs/outputs to corresponding pins on the Go Board.
4. Click `Tools/Run All`. This should generate a `.bin` file in `P&R Flow/Output Files/Bitmap/${filename}.bin`
5. In Diamond Programmer, click `Program` button on toolbar. If status `FAILS` just change the port of the cable. Ensure you the `programmer_config.xcf` file is opened. If `Data Expected: h10  Actual: hFF` error occurs, change the port in cable settings.

### Diamond Programmer Setup
Ensure that the Go Board is connected to the computer. <br>

1. Create a new project from a scan. The cable and port should be available. Press OK
2. The program will scan for the Go Board 
3. Set device family to `iCE40` and  device to `iCE40HX1K`
4. In Operation, set Access Mode to `SPI Flash Programming`
5. In Operation, add Programming file from `iCEcube2/project-name/sbt/outputs/bitmap/.bin`
6. In Operation, set `SPI Flash Options`
    - Vendor: Micron
    - Device: SPI-M25P10-A or M25P10
    - Package: 8-pin 
7. Save as `programmer_config` in project root folder