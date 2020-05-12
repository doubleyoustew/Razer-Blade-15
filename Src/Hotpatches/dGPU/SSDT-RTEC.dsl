/*
 * Find Method (RTEC:      4d 65 74 68 6f 64 20 28 52 54 45 43
 * Replace Method (XTEC:   4d 65 74 68 6f 64 20 28 58 54 45 43
 */
DefinitionBlock("", "SSDT", 2, "hack", "RTECFix", 0)
{
    External (_SB.PCI0.LPCB.EC, DeviceObj)
    
    Scope (\_SB.PCI0.LPCB.EC)
    {
        Method (RTEC, 0, NotSerialized)
        {
        }
    }
}