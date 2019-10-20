set_mixer_control! lpf:130, amp:0.5
live_loop :time do
  sleep 0.5
end

live_loop :pads, sync: :time do
  use_synth :dsaw
  4.times do
    r1 = (ring :g3, :f3, :a3, :b3)
    play r1.tick, amp: 0.7, attack: 1, release: 4, cutoff: rrand(90,130)
    sleep 4
  end
end

live_loop :padssliced, sync: :time do
  with_fx :panslicer, pan_min: -0.6, pan_max: 0.6 do
    with_fx :slicer, phase: 0.125, pulse_width: 0.6 do
      use_synth :dsaw
      4.times do
        ##r1=(ring :g3, :f3, :a3, :b3)
        r1 = (ring :g3, :f3, :a3, :b3)
        play r1.tick, amp: 0.8, attack: 0.9, release: 4, cutoff: rrand(80,100)
        sleep 4
      end
    end
  end
end

live_loop :lead, sync: :time do
  with_fx :distortion, amp: 1, distort: rrand(0.0, 0.1) do
    use_synth :fm
    
    32.times do
      r1 = (ring :c4, :e4, :c4, :g4)
      play r1.tick, release: 0.25, cutoff: rrand(100,130)
      sleep 0.125
    end
    
    32.times do
      r1 = (ring :c4, :e4, :c4, :f4)
      play r1.tick, release: 0.25, cutoff: rrand(100,130)
      sleep 0.125
    end
    
    32.times do
      r1 = (ring :c4, :e4, :c4, :a4)
      play r1.tick, release: 0.25, cutoff: rrand(100,130)
      sleep 0.125
    end
    
    32.times do
      r1 = (ring :c4, :e4, :c4, :b4)
      play r1.tick, release: 0.25, cutoff: rrand(100,130)
      sleep 0.125
    end
    
  end
end
