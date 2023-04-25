# Marc Duiker
# 2023-04-25

r1 = (ring :F3, :D3, :F3, :D3, :F3, :D3, :F3, :D2)
r2 = (ring :F3, :D3, :F3, :D4, :F3, :D3, :F3, :F4)
r3 = (ring :F3, :D3, :F3, :D3, :F3, :D3, :F3, :D2)
r4 = (ring :G3, :D3, :G3, :D4, :A3, :G3, :A3, :G4)

rall = r1 + r2 + r3 + r4

ampDrums = 0
ampLoop1 = 0.6
ampLoop2 = 0

live_loop :drums do
  with_fx :lpf, mix: 1, cutoff: [130, 115, 100, 80].tick, amp: ampDrums do
    use_random_seed 500
    8.times do
      sample :bd_haus
      sleep 0.25
      sample :drum_cymbal_closed
      sleep 0.25
      sample :bd_haus
      sample :elec_hi_snare
      sleep 0.25
      if one_in(3)
        sample :drum_cymbal_closed
      else
        sample :drum_cymbal_pedal
      end
      sleep 0.25
    end
  end
end

live_loop :loop1 do
  use_synth :mod_dsaw
  with_fx :echo, mix: 0.6, phase: 0.5, decay: 1, amp: 0.5 do
    ramp1 = (line -0.5, 0.5, step: 0.11, inclusive: true)
    p = play rall.tick, divisor: 1, div_slide: rrand(0, 10), depth: 1, attack: 0.001, release: 0.4, amp: ampLoop1
    control p, cutoff: rrand(80, 130), pan: ramp1.tick
    sleep 0.25
  end
end

live_loop :loop2 do
  use_synth :saw
  with_fx :reverb, damp: 0.3, room: 0.9 do
    with_fx :distortion, mix: 0.9, amp: 0.6, distort: 0.5 do
      p = play r1.tick - 12, depth: 1, attack: 0.2, decay: 0.3, sustain: 0.6, release: 1.1, div: 1, amp: ampLoop2
      control p, cutoff: rrand(70, 90)
      sleep 2
    end
  end
end