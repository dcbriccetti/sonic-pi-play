PI = 3.14159
gradations = 100
length_beats = 10
beats_per_gradation = length_beats.to_f / gradations
use_synth_defaults attack: 0.5, sustain: length_beats, release: 0.5
use_synth :beep
3.times do
  with_fx :slicer do
    n1 = play :c3
    n2 = play :c5
    (0..gradations).each do |n|
      angle = (n.to_f / gradations) * PI * 2
      control n1, pan: Math.cos(angle)
      control n2, pan: -Math.cos(angle)
      sleep beats_per_gradation
    end
  end
  sleep 1
end
