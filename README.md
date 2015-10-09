# TraceUtility

A proof of concept on how to parse .trace documents generated by Instruments, using the undocumented frameworks shipped with Instruments.

We only need to link against these two frameworks in `/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/Frameworks`

* `DVTInstrumentsFoundation.framework`
* `InstrumentsPlugIn.framework`

Instrument templates used by the app are plugins in `/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns`

Such as `SamplerPlugin.xrplugin` for Time Profiler, `MemoryPlugin.xrplugin` for Leak

The code is for leak trace parser.

# Usage:
1. Build the project
2. Run ~/Xcode/DerivedData/TraceUtility-xxxxxx/Build/Products/Debug/TraceUtility \<path to the Memory.trace file\>

# Example for output:
Leaked Object:16, Address:0x7b81c590

Leaked Object:16, Address:0x7b83b7c0

Leaked Object:16, Address:0x7b93a4d0

Leaked Object:32, Address:0x7ba79b60

.......


