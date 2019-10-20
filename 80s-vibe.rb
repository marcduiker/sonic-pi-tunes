live_loop :foo do
  with_fx :reverb, room: 0.8, damp: 0.2 do
    with_fx :distortion, distort: rrand(0.4, 0.7) do
      f = (ring :f3, :g3, :c3, :d3).tick
      use_synth :blade
      play f, amp: 1, release: 0.1, cutoff: rrand(75, 130)
      sleep 0.125
    end
  end
end

live_loop :lead do
  use_synth :sine
  l = (ring :a5, :a5, :a5, :a5).tick
  play l, amp: 1, release: 0.5
  sleep 1
end

live_loop :lead2 do
  sync :lead
  use_synth :sine
  sleep 2
  play :e6, amp: 1, release: 0.5
  sleep 0.25
  play :d6, amp: 1, release: 0.5
  sleep 0.25
  play :f6, amp: 1, release: 0.5
  sleep 1
end


