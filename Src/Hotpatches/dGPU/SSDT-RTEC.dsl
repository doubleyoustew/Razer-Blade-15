DefinitionBlock("", "SSDT", 2, "hack", "RTECFix", 0)
{
    External (_SB.PCI0.LPCB.EC0, DeviceObj)
    
    Scope (\_SB.PCI0.LPCB.EC0)
    {
        Method (RTEC, 0, NotSerialized)
        {
        }
    }
}