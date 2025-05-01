# Building TangCore

Here's how to build the TangCore distribution, including the firmware, the monitor core and 4 game cores.

## Setting up the environment

* Windows 10 or 11
* Install Gowin IDE 1.9.10.3 and 1.9.11. Both are needed for the building process.
* Install [git for windows](https://git-scm.com/downloads/win).
* Checkout tangcore and BL616 SDK/toolchain.
```batch
mkdir \Gowin\dev
cd \Gowin\dev
git clone --recursive https://github.com/nand2mario/tangcore.git
cd tangcore
git clone --recurse-submodules https://github.com/vossstef/bouffalo_sdk.git
git clone https://github.com/bouffalolab/toolchain_gcc_t-head_windows.git
```
* Add the following dirs to path: `toolchain_gcc_t-head_windows\bin`, `bouffalo_sdk\tools\make`, `bouffalo_sdk\tools\cmake\bin`, `bouffalo_sdk\tools\ninja`

## Build the firmware

First, obtain Sipeed **official firmware** [here](https://dl.sipeed.com/shareURL/TANG/Console/09_MCU_FW) and save in `tangcore\firmware-bl616`.

```batch
cd tangcore\firmware-bl616

buildall         # build for all boards

set TANG_BOARD=primer25k
make             # build for one board
```

## Build the cores

```batch
cd tangcore\nestang
buildall         # build for all boards

# the same for snestang, gbatang, mdtang and monitor
```

## Collect building results

```batch
cd tangcore
build package
```
This will collect all built artifacts and put them in `build/`.