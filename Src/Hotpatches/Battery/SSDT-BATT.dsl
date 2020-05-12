/*
 * Razer Blade early 2019 Batter Fix
 *
 * Don't forget to apply these patches in clover/opencore:
 * 
 *    Find _BIF:       14 44 13 5F 42 49 46 00
 *    Replace _BIZ:    14 44 13 5F 42 49 5a 00
 *
 *    Find _BST:       14 4D 09 5F 42 53 54 00
 *    Replace _BSZ:    14 4D 09 5F 42 53 5a 00
 *
 */

DefinitionBlock("", "SSDT", 2, "HACK", "BATT", 0)
{
    External (_SB.PCI0.LPCB, DeviceObj)
    External (_SB.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.ECUP, UnknownObj)
    External (_SB_.PCI0.LPCB.EC__.ECON, UnknownObj)
    External (_SB_.PCI0.LPCB.EC__.PSTA, UnknownObj)
    External (_SB.PCI0.LPCB.BAT0, DeviceObj)
    External (_SB.PCI0.LPCB.PAK1, UnknownObj)
    External (_SB.PCI0.LPCB.BFB0, UnknownObj)
    
    Scope (_SB.PCI0.LPCB)
    {
        Scope (EC)
        {
            OperationRegion (ERM2, EmbeddedControl, 0x90, 0x0A)
            Field(ERM2, ByteAcc, NoLock, Preserve)
            {
                //ECCX,256,//ECCM,256, patch?
                IF00,    8,
                IF01,    8, 
                IF10,    8,
                IF11,    8, 
                IF20,    8,
                IF21,    8, 
                IF30,    8,
                IF31,    8, 
                IF40,    8,
                IF41,    8
            }
            
            OperationRegion (ERM3, EmbeddedControl, 0xA2, 0x08)
            Field (ERM3, ByteAcc, NoLock, Preserve)
            {
                ST00,    8,
                ST01,    8, 
                ST10,    8,
                ST11,    8, 
                ST20,    8,
                ST21,    8, 
                ST30,    8,
                ST31,    8
            }
            
            Method (RE1B, 1, NotSerialized)
            {
                OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
                Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
                Return(BYTE)
            }
            Method (RECB, 2, Serialized)
            {
                ShiftRight(Add(Arg1,7), 3, Arg1)
                Name(TEMP, Buffer(Arg1) { })
                Add(Arg0, Arg1, Arg1)
                Store(0, Local0)
                While (LLess(Arg0, Arg1))
                {
                    Store(RE1B(Arg0), Index(TEMP, Local0))
                    Increment(Arg0)
                    Increment(Local0)
                }
                Return(TEMP)
            }
        }
        
        Scope (BAT0)
        {
            Method (_BIF, 0, NotSerialized)
            {
                If (^^EC.ECUP)
                {
                    Return (PAK1)
                }

                If (LEqual (^^EC.ECON, One))
                {
                    And (^^EC.PSTA, 0x02, Local0)
                    If (Local0)
                    {
                        Store (B1B2(^^EC.IF00,^^EC.IF01), Local0)
                        Store (Local0, Index (PAK1, Zero))
                        If (Local0)
                        {
                            Store (B1B2(^^EC.IF10,^^EC.IF11), Index (PAK1, One))
                            Store (B1B2(^^EC.IF20,^^EC.IF21), Index (PAK1, 0x02))
                        }
                        Else
                        {
                            Multiply (B1B2(^^EC.IF10,^^EC.IF11), 0x0A, Local1)
                            Store (Local1, Index (PAK1, One))
                            Multiply (B1B2(^^EC.IF20,^^EC.IF21), 0x0A, Local1)
                            Store (Local1, Index (PAK1, 0x02))
                        }

                        Store (B1B2(^^EC.IF30,^^EC.IF31), Index (PAK1, 0x03))
                        Store (B1B2(^^EC.IF40,^^EC.IF41), Index (PAK1, 0x04))
                        Store (Divide (B1B2(^^EC.IF10,^^EC.IF11), 0x32, ), Index (PAK1, 0x05))
                        Store (Divide (B1B2(^^EC.IF10,^^EC.IF11), 0x64, ), Index (PAK1, 0x06))
                        Store (ToString (^^EC.RECB(0x60,256), 0x20), Index (PAK1, 0x0A))
                        Return (PAK1)
                    }
                    Else
                    {
                        Return (PAK1)
                    }
                }
                Else
                {
                    Return (PAK1)
                }
            }
            Method (_BST, 0, NotSerialized)
            {
                If (^^EC.ECUP)
                {
                    Return (BFB0)
                }

                If (LEqual (^^EC.ECON, One))
                {
                    And (^^EC.PSTA, 0x02, Local0)
                    If (Local0)
                    {
                        Store (B1B2(^^EC.ST00,^^EC.ST01), Index (BFB0, Zero))
                        Store (B1B2(^^EC.ST10,^^EC.ST11), Index (BFB0, One))
                        Store (B1B2(^^EC.ST20,^^EC.ST21), Index (BFB0, 0x02))
                        Store (B1B2(^^EC.ST30,^^EC.ST31), Index (BFB0, 0x03))
                        Return (BFB0)
                    }
                    Else
                    {
                        Return (BFB0)
                    }
                }
                Else
                {
                    Return (BFB0)
                }
            }
        }
    }
    
    Method (B1B2, 2, NotSerialized) { Return(Or(Arg0, ShiftLeft(Arg1, 8))) }

}