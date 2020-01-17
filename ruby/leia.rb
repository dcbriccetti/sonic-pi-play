use_bpm 120
use_synth_defaults sustain: 0.8, release: 0.2

in_thread do
  play_pattern_timed %i[g3 g3 e4 e4 e4 f4 f4 e4 d4],
    [1, 1, 1, 5, 1, 1, 0.5, 0.5, 5], amp: 2
end

in_thread do
  sleep 1
  play_chord chord(:c, :major), sustain: 8
  sleep 8
  play_chord chord(:f, :minor), sustain: 7
  sleep 8
end
