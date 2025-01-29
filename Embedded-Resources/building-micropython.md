to allow us to build micropython we need to install the espressif-idf tools. Once installed we need to activate by running

`$ source ~/esp-idf/export.sh`

Clone the micropython source.
`$ git submodule update --init --recursive`

build the cross compiler (mpy-cross)
`$ cd ..../micropython/mpy-cross`
`$ make -j$(nproc)`
`$ cd ..../micropython`

navigate to esp32 port
`$cd ..../micropython/ports/esp32`

now we can specify the board to target
`make BOARD=GENERIC`
`make BOARD=ESP32_GENERIC_S3`
*we can see available boards in micropython/ports/esp32/boards*

now we can flash to the board
`python -m esptool --chip esp32s3 -b 460800 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_size 8MB --flash_freq 80m \
  0x0 build-ESP32_GENERIC_S3/bootloader/bootloader.bin \
  0x8000 build-ESP32_GENERIC_S3/partition_table/partition-table.bin \
  0x10000 build-ESP32_GENERIC_S3/micropython.bin`



