# Developing a new core

[NESTang](https://github.com/nand2mario/nestang) can be used as a template for developing gaming cores for Tang Console. Here're the minimal set of parts that a core should have so it can be loaded by the TangCore template:

* `src/somecore_top.v`: the core top source file. As nestang_top.v shows, it should contains the machine-specific components, a HDMI display module and `iosys_bl616`, which is an interface over UART to the BL616 MCU.
* `src/hdmi/*`: HDMI display components
* `src/iosys/iosys_bl616.v`: the interface (referred to as "IO system") over UART to the BL616 MCU.
* `src/iosys/textdisp.v`: 32x28 text mode display to show the overlay text
* `src/iosys/uart_fixed.v`: the UART TX/RX modules

The other older io system module is `iosys_picorv32.v`. It uses a risc-v softcore running inside the FPGA to act as the IO processor. New cores should use `iosys_bl616`, the newer module.

If you open `iosys_bl616.v`, you will see that it provides a few useful pins,
* `overlay*`: these are signals for the "on-screen display" (OSD). It outputs a 256x224 image. When `overlay==1` (controlled by the MCU), it will be shown on screen. Note that `overlay*` run in the `hclk` (HDMI clock) domain, the rest of the signals run in `clk` domain.
* `joy*`: inputs to iosys. These joypad button states will be sent periodically to MCU to control the overlay menu.
* `rom_*`: When MCU starts ROM loading through the UART interface, data is output through these pins to the actual core.
* `uart_*`: UART signal pads. These are the main interface between the core and the MCU.

The [hdl-util/HDMI](https://github.com/hdl-util/hdmi) interface should run in 720p mode. Please refer to nestang_top.v and the HDMI module author's documentation for how to use it.

Please [file an issue](https://github.com/nand2mario/tangcore/issues) if you met issues in building your core.

## Generating core logo

Whenever a core is loaded on the FPGA, its logo is displayed at the bottom of the overlay page. When you create
a new core, you probably want to make a new logo too. There is a script to help with that.

```bash
cd tangcore/monitor/scripts
python genlogo.py
```

This will print out something like this, that you can put in `iosys/gowin_dpb_menu.v` to change the logo.

```
defparam dpb_inst_0.INIT_RAM_1C = 256'hE0077CF80E00000000E00F78780E00000007FDFE7079FE00000007FCFC7031F8
defparam dpb_inst_0.INIT_RAM_1D = 256'h8039DC67F0E3FC77BBFC39DC6600E1FE7FF9FE3FDFE7F0E00F7CF80E3F8FE7F0
defparam dpb_inst_0.INIT_RAM_1E = 256'hF0E1FE7039FE3F9C67F0E3FE703BFE39DC6630E380733B8039DC67F0E38077BB
defparam dpb_inst_0.INIT_RAM_1F = 256'h00000C00000000000000003F8000000000000000398000000000000000381C66
```
