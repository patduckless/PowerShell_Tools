$Code = @'
using System;

[FlagsAttribute]
public enum FileAttributesEx : uint {
	Readonly = 0x00000001,
	Hidden = 0x00000002,
	System = 0x00000004,
	Directory = 0x00000010,
	Archive = 0x00000020,
	Device = 0x00000040,
	Normal = 0x00000080,
	Temporary = 0x00000100,
	SparseFile = 0x00000200,
	ReparsePoint = 0x00000400,
	Compressed = 0x00000800,
	Offline = 0x00001000,
	NotContentIndexed = 0x00002000,
	Encrypted = 0x00004000,
	IntegrityStream = 0x00008000,
	Virtual = 0x00010000,
	NoScrubData = 0x00020000,
	EA = 0x00040000,
	Pinned = 0x00080000,
	Unpinned = 0x00100000,
	U200000 = 0x00200000,
	RecallOnDataAccess = 0x00400000,
	U800000 = 0x00800000,
	U1000000 = 0x01000000,
	U2000000 = 0x02000000,
	U4000000 = 0x04000000,
	U8000000 = 0x08000000,
	U10000000 = 0x10000000,
	U20000000 = 0x20000000,
	U40000000 = 0x40000000,
	U80000000 = 0x80000000
}
'@
Add-Type $Code

Get-ChildItem $((Get-ChildItem $env:USERPROFILE -Filter "OneDrive -*").FullName) -Exclude "*.url" -Recurse | 
    Where {! $_.PSIsContainer } |
    Select Fullname, @{n='Attributes';e={[fileAttributesex]$_.Attributes.Value__}} | 
    where-Object { ($_.Attributes -cnotmatch "Unpinned") -or ($_.Attributes -cnotmatch "Offline") -And ($_.Attributes -cnotmatch "RecallOnDataAccess")  } |
    Foreach {  attrib.exe $_.fullname +U -P /S }