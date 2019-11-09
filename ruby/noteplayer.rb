# Run this in Sonic Pi to play the notes from BubbleSortSonicPi.kt

live_loop :foo do
  args = sync "/osc/play"
  use_synth :tri
  with_bpm args[0] do
    notes = args[1..-1]
    play_pattern notes
  end
end
