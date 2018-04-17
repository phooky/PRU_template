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

