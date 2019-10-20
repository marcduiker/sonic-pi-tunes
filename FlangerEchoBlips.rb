#              1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
bpattern =    [1, 0, 1, 0, 1, 1, 3, 0, 1, 0, 1, 0, 1, 0, 3, 2]

live_loop :blips do
  with_bpm 130 do
    with_fx :echo, amp:1, mix:0.1, phase:0.25, decay:4 do
      with_fx :reverb, mix:0.3 do
        with_fx :distortion, distort:rrand(0.6, 1), mix:rrand(0.2, 0.3) do
          bpattern.each do |p|
            use_synth :dpulse
            use_synth_defaults attack:0.125, release:0.125, pan:rrand(-0.5,0.5), cutoff:rrand(50, 130)
            play [:c3, :c4] if p==1
            play [:c4, :e4] if p==2
            play [:e3, :e4] if p==3
            sleep 0.25
          end
        end
      end
    end
  end
end
