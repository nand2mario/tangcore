# Troubleshooting

## There's no video output

Check the following,

* Have you flashed the correct firmware for your board with Bouffalo Flash Cube? There's one .ini file for each board.
* Make sure USB drive contains `/cores/<your_board>/monitor.bin`. This is the bitstream that displays the menu.
* For Primer/Console, use USB-OTG dongle with power pass-through to connect USB and power.
* For Mega, either use OTG or the USB-A Host port on the board to connect USB drive. If USB-A is used, make sure the switch below is set to "DBG" instead of "FPGA".
* Do NOT connect the board to PC for power when you intend to run TangCore. Use a separate power supply. The Sipeed firmware enters JTAG/debug mode when PC is detected.
* For Tang Mega, don't forget to turn on power (long press POWER button on top)

## I cannot navigate the menu

Check controller connection. Dualshock controller support is most stable:

* For Mega, insert the DS2 pmod into the left pmod socket (pmod0).
* For Console, use the top pmod socket (pmod1).
* For Primer, use the middle pmod socket for DS2.

If you use USB controllers,

* Only the Sipeed-provided USB gamepads can be used with the on-board USB-A port. If it is not recognized, replug the pad.
* Other types of USB gamepads needs a USB hub to work. Please follow instructions on the [controllers page](controllers.md).

