# Getting started with the PRU C/assembly hybrid template

1. Get the TI code generation tools for the PRU. The current version can be found at:
   
   [http://www.ti.com/tool/download/PRU-CGT-2-1]
   
   Once the download has completed, install the CGT package.
2. Add the installation directory to your environment:
   
   ```bash
   export PRU_CGT=/path/to/ti-cgt-pru/
   ```
3. Edit this template's Makefile to indicate which PRU number and target chip you're using.
4. Put all your C and assembly sources in the src directory.

# Deploying the firmware

This guide assumes you're on a Beagleboard with a recent kernel.

1. Copy the generated `am335x-pruN-fw` file to the `/lib/firmware` directory on your target
   machine.
2. Load the firmware. Note that PRU0 is `remoteproc1` and PRU1 is `remoteproc2`. `remoteproc0`
   is the power management Cortex-M0.
   
   ```echo 'am335x-pru0-fw' > /sys/class/remoteproc/remoteproc1/firmware```
3. Start the firmware.
   ```echo 'start'> /sys/class/remoteproc/remoteproc1/state```
   
   You can write `stop` instead to halt the PRU. If you're running the default script, any
   PRU output pins you have muxed will toggle on and off at half-second intervals. (Be sure you've
   got your pins muxed correctly if you're expecting to see a signal!)

