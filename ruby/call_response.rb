bpm = 120
use_bpm bpm
use_synth :saw

notes = chord(:bf4, :major)
highest = 0

live_loop :call do
  use_bpm bpm
  4.times do
    play notes[0..highest].pick
    sleep 1
  end
  sleep 4
  highest += 1 unless highest == notes.length - 1
end

live_loop :rhythm do
  use_bpm bpm
  sleep 4
  4.times do
    sample :drum_cymbal_closed
    sleep 1
  end
end

live_loop :speeder do
  use_bpm bpm
  sleep 8
  bpm += 5
end
