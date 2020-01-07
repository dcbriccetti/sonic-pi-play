use_bpm 120
q = 1
e = 0.5

live_loop :bass do
  use_synth_defaults attack: 0, decay: 0.1, sustain: 0.4, release: 0.2
  with_transpose 0 do  # raise by 12 if your speakers can’t play that low
    play_pattern_timed %i[d2 d3 c3 d3 r a2 c3 a2], e
    play_pattern_timed %i[d2 d2 e2 f2 f2 fs2], [e, e, q, q, e, e]
    play_pattern_timed %i[g2 g2 f2 g2 g2 d2 f2 g2], e
    play_pattern_timed %i[a2 a2 c3 a2 c3 d3], [q, q, e, e, e, e]
  end
end

live_loop :drums do
  sample :drum_heavy_kick
  sleep 1
  sample :drum_cymbal_closed
  sleep 1
end

live_loop :chords do
  use_synth :dsaw
  use_synth_defaults release: 3, amp: 0.5
  2.times do
    play_chord chord(:d, :minor)
    sleep 4
  end
  play_chord chord :g, :minor
  sleep 4
  2.times do
    play_chord chord(:a, :minor), release: 1.5
    sleep 2
  end
end
