def play_dial_tone
  for hz in [350, 440]
    play hz_to_midi(hz), sustain: 2, release: 0
  end
end

def dial_number(phone_number)
  frequency_pairs = [# Touch-Tone frequencies for 0–9
      [941, 1336], [697, 1209], [697, 1336], [697, 1447], [770, 1209],
      [770, 1336], [770, 1447], [852, 1209], [852, 1336], [852, 1447],
  ]
  digits = phone_number.split('').select { |ch| ch =~ /\d/ }
  digits.each do |digit|
    for pair_index in 0..1
      midi_note = hz_to_midi(frequency_pairs[digit.to_i][pair_index])
      play midi_note, sustain: 0.05, release: 0
    end
    sleep 0.1
  end
end

def play_busy
  with_fx(:slicer, phase: 1) do
    for hz in [480, 620]
      play hz_to_midi(hz), sustain: 3.99, release: 0
    end
    sleep 4
  end
end

play_dial_tone
sleep 2
dial_number('1 (555) 284-1234')
sleep 0.5
play_busy

