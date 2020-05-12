# Razer-Blade-15

## Things that don't work or are untested

### USB-C Data / Thunderbolt

I don't have a Thunderbolt device or a USB-C to USB-C cable to test this at the moment. It might work, but I don't know.

### High refresh rates / 4k@60hz

1440p@144hz doesn't work right after booting. Putting the laptop to sleep and waking it back up fixes this. You can use high refresh rates, but keep that in mind. I have heard of similar problems with 4k monitors but I don't have one.

## Manual steps

There are a couple of things you need to do manually, in order to make everything work.

### Download contents of EFI/OC/Resources

I didn't include it in the repo, best to download it [here](https://github.com/acidanthera/OcBinaryData) and put it in EFI/OC/Resources.

### Unlock your BIOS

Use [stonevil/Razer_Blade_Advanced_early_2019_Hackintosh](https://github.com/stonevil/Razer_Blade_Advanced_early_2019_Hackintosh) for this part. He describes the nessesary steps.

### Generate your unique serials

See [Dortania Laptop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/post-install/iservices.html) on how to do this. Keep everything else as is, just replace the CHANGE_ME parts.

### Jackfix

If you have problems with distorted audio over the jack, use [jackfix](https://github.com/fewtarius/jackfix).

These are my settings for the pins. Replace this part in jackfix.sh:

    ${IPATH}/hda-verb 0x18 SET_PIN_WIDGET_CONTROL 0x24
    ${IPATH}/hda-verb 0x19 SET_PIN_WIDGET_CONTROL 0x24
    ${IPATH}/hda-verb 0x1f SET_PIN_WIDGET_CONTROL 0x24

### Razer Chroma

### Moving over from Clover

