use_synth :mod_dsaw
loop do
  use_bpm rrand(50, 300)         # Choose a tempo randomly
  use_transpose rrand_i(-12, 12) # Choose a starting note randomly
  (1..4).each do |range|         # Play a stereo chord with increasing modulation ranges
    use_synth_defaults attack: 0.2, mod_phase: 0.25, mod_range: range, detune: 0.1
    play :c, pan: -1
    play :ef, pan: 0
    play :g, pan: 1
    sleep 1
  end
end
