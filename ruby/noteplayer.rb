live_loop :foo do
  use_bpm 600
  notes = sync "/osc/play"
  play_pattern notes
end

