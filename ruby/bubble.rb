use_bpm 240
use_synth :pretty_bell
notes = scale(:c3, :major_pentatonic, num_octaves: 2).shuffle.to_a
swapping = true

while swapping
  play_pattern_timed notes, 1, release: 1.2
  swapping = false
  (0..notes.size - 2).each do |i|
    next unless notes[i] > notes[i + 1]

    puts "Swapping #{i} and #{i + 1}, #{notes[i]} and #{notes[i + 1]}"
    notes[i], notes[i + 1] = notes[i + 1], notes[i]
    swapping = true
  end
  sleep 1
end

play_pattern_timed notes, 1.0 / 4, release: 1
