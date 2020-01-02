use_bpm 60
use_synth :pulse

notes = scale(:c3, :major)
play_pattern_timed notes, 0.2, release: 0.1
sleep 2

live_loop :notes do
  4.times do
    play notes.pick
    sleep 1
  end
  sleep 4
end

live_loop :rhythm do
  4.times do
    sample :drum_heavy_kick
    sleep 1
  end
end

