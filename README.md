# Razer Blade 15 (early 2019) Opencore

This is my opencore config for the Razer Blade 15. I'm currently running Mojave with this config, but it also works with Catalina (with minor changes, see below). Most stuff works, but there are minor quirks that still need some work. Use this as is or as a starting point for your hackintosh.

## Things that don't work or are untested

### USB-C Data / Thunderbolt

I don't have a Thunderbolt device or a USB-C to USB-C cable to test this at the moment. It might work, but I don't know.

### High refresh rates / 4k@60hz

1440p@144hz doesn't work right after booting. Putting the laptop to sleep and waking it back up fixes this. You can use high refresh rates, but keep that in mind. I have heard of similar problems with 4k monitors but I don't have one.

### No audio after booting without external power

Still looking into this one. It's most commonly happening if I boot the laptop without the power plug. Codec Command or a different ALC layout might fix this.

### No audio over USB-C to DP or HDMI

This has been looked into but there is no obvious solution. I don't really need it so I'll probably won't investigate this further.

### Laptop waking up from sleep

The laptop wakes from sleep irregularly. It goes back to sleep after. Probably some USB issue but I haven't found a fix as of yet.

## Manual steps

There are a couple of things you need to do manually, in order to make everything work.

### Download contents of EFI/OC/Resources

I didn't include it in the repo, best to download it [here](https://github.com/acidanthera/OcBinaryData) and put it in EFI/OC/Resources.

### Unlock your BIOS

Use [stonevil/Razer_Blade_Advanced_early_2019_Hackintosh](https://github.com/stonevil/Razer_Blade_Advanced_early_2019_Hackintosh) for this part. He describes the nessesary steps.

### Generate your unique serials

See [Dortania Laptop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/post-install/iservices.html) on how to do this. Keep everything else as is, just replace the CHANGE_ME parts.

### Using macOS Catalina

This config should work just as well to run Catalina. The only difference is that you'll need to use BrcmPatchRAM3.kext instead of BrcmPatchRAM2.kext to get Bluetooth working. [Download it here.](https://github.com/acidanthera/BrcmPatchRAM/releases)

### Jackfix

If you have problems with distorted audio over the jack, use [jackfix](https://github.com/fewtarius/jackfix).

These are my settings for the pins. Replace this part in jackfix.sh:

    ${IPATH}/hda-verb 0x18 SET_PIN_WIDGET_CONTROL 0x24
    ${IPATH}/hda-verb 0x19 SET_PIN_WIDGET_CONTROL 0x24
    ${IPATH}/hda-verb 0x1f SET_PIN_WIDGET_CONTROL 0x24

### Razer Chroma

If you want to control the lighting on your keyboard, you can use [Razer Control by BlvckBytes](https://github.com/BlvckBytes/RazerControl). If you just want it static white or prefer the command line you can also use [osx-razer-led](https://github.com/dylanparker/osx-razer-led).

### Moving over from Clover

If you're moving over from clover, make sure to:

- Remove all Kext you might have installed to L/E or S/L/E
- Clear your NVRAM (Opencore boot option)
- [Remove any files clover may have left.](https://github.com/dortania/OpenCore-Desktop-Guide/tree/master/clover-conversion)