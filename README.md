# shout

Simple speech-to-text for Wayland/Hyprland. Press a key to record, press again to transcribe and press Enter.

Works great with AI coding agents like Claude Code - they're forgiving of typos and excellent at semantic reasoning, so transcription doesn't need to be perfect.

## Installation (Omarchy/Arch Linux)

```bash
yay -S whisper.cpp whisper.cpp-model-tiny wtype
git clone https://github.com/robzolkos/shout.git
cd shout
./install.sh
```

Uses the `tiny` whisper model (75 MB) - fastest transcription, good enough for AI agents.

## Usage

1. Press `Super+R` to start recording
2. Speak
3. Press `Super+R` again to stop, transcribe, and press Enter

## License

MIT
