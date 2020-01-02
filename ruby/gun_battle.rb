def shoot(sample, num_times, between, pan = 0, rate = 1)
  with_fx(:reverb, room: 0.5, mix: 0.5) do
    num_times.times do
      sample sample, pan: pan, rate: rate
      sleep between
    end
  end
end

fbi_pan = 1
robber_pan = -1

live_loop :fbi do
  if fbi_pan > 0
    shoot(:bd_haus, rrand_i(1, 10), 0.1, fbi_pan)
    fbi_pan -= 0.1
  end
  sleep rrand(1, 3)
end

live_loop :robber do
  if robber_pan < 0
    shoot(:bd_haus, rrand_i(0, 5), 0.5, robber_pan, rate = 0.5)
    robber_pan += 0.1
  end
  sleep rrand(0, 2)
end
