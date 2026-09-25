# aap-juce-dusk-audio-plugins: port of Dusk Audio Plugins to AAP

It is [dusk-audio/dusk-audio-plugins](https://github.com/dusk-audio/dusk-audio-plugins)
ported to [AAP (Audio Plugins For Android)](https://github.com/atsushieno/aap-core),
using [aap-juce](https://github.com/atsushieno/aap-juce).

dusk-audio-plugins is a collection of JUCE (and DAF) plugins in one source tree.
This app packages the following JUCE plugins in one APK:

- 4K EQ
- Multi-Comp
- TapeMachine
- Multi-Q
- Spectrum Analyzer
- Chord Analyzer (the instrument variant, which passes audio through)
- DuskVerb
- Tape Echo

They are hosted by one AudioPluginService in one process, and each plugin
library has its own JUCE runtime. It requires some tweaks to the usual aap-juce
app setup (e.g. we do not compile the JUCE Java sources); see "More Than One
JUCE Plugin Library in an App" in aap-juce `docs/JUCE_GUI_SUPPORT.md`.

Convolution Reverb, DuskAmp and GrooveMind are not ported yet (they are still
in development upstream, and they depend on files that are not accessible in
the same way on Android). The DAF-based plugins are out of scope of aap-juce.

## Building

`make` builds the app. dusk-audio-plugins does not contain JUCE, so we have our
own JUCE submodule (`external/JUCE`), which is passed to the upstream build as
`JUCE_PATH` (see `app/build.gradle`).

To add another plugin in dusk-audio-plugins, add its CMake target to
`duskPluginTargets` in `app/build.gradle` and its `<plugin>` element to
`app/src/main/res/xml/aap_metadata.xml` (`library="lib{target}_Standalone.so"`),
and make sure that the plugin builds the `Standalone` format on Android
(see `aap-juce-support.patch`).

## License

dusk-audio-plugins is released under the GPLv3 license.

aap-juce-dusk-audio-plugins is released under the AGPLv3 license.
