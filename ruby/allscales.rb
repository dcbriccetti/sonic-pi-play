use_bpm 120
root = 60
use_synth_defaults sustain: 1, release: 0.1
12.times do
  play_pattern_timed scale(root, :major), 1
  root += 5
  root -= 12 if root > 72
end
