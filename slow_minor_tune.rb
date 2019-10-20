## Slow Minor Tune
## Marc Duiker => @marcduiker

use_bpm 90

live_loop :metronome do
  sleep 0.25
end

live_loop :drums, sync: :metronome do
  with_fx :distortion, distort: 0.7, mix: 0.7, amp: 0 do #0.6
    with_fx :flanger, depth: 8, phase: 2, feedback: 10, mix: 0.6, amp: 0.3 do
      ##| sample :bd_haus, lpf: 100
      sleep 0.5
      ##| sample :elec_blip
      sleep 0.5
      ##| sample :bd_haus, lpf: 100
      sample :sn_dolf, lpf: 110
      sleep 0.5
      ##| sample :elec_blip
      sleep 0.5
      ##| sample :bd_haus, lpf: 100
      sleep 0.5
      sample :elec_cymbal, lpf: 110, amp: 0.5 , attack: 0.15
      sleep 0.5
      ##| sample :bd_haus, lpf: 100
      sample :sn_dolf
      sleep 0.5
      sample :elec_plip
      sleep 0.5
    end
  end
end


live_loop :bassline, sync: :metronome do
  use_synth :pulse
  ##| bassnotes = (ring :Bs1, :Bs1, :Bs1, :Bs1, :Es1, :Es1, :Es1, :Bs2)
  bassnotes = (ring :Bs1)
  with_fx :reverb, room: 0.2, mix: 0.2, amp: 0.5 do
    with_fx :nrlpf, cutoff: rrand(80, 130), res: rrand(0.3, 0.9), mix: 0.8, amp: 1 do
      with_fx :distortion, distort: 0.9, amp: 0.8 do
        sleep 0.25
        ##| play bassnotes.choose, attack: 0, decay: 0.1, release: rrand(0.15, 0.23), pan: rrand(-0.5, 0.5), amp: 0.6
      end
    end
  end
end

live_loop :bells, sync: :metronome do
  use_synth :sine
  bellnotes = (ring :Es4, :Es4, :Bs3, :Bs4, :Es4, :Es4, :Bs3, :Bs5)
  with_fx :reverb, room: 0.2, mix: 0.7, amp: 0.7 do
    with_fx :echo, decay: 2, phase: 0.75, mix: 0.9, amp: 1 do
      sleep 0.5
      play bellnotes.tick, attack: 0, decay: 0.1, release: 0.2, amp: 0.7, pan: rrand(-0.7, 0.7)
      sleep 0.5
    end
  end
end

live_loop :pads, sync: :metronome do
  with_fx :gverb, spread: 0.2, room: 100, damp: 0.6, release: 8, mix: 0.7, amp: 0.7 do
    use_synth :fm
    ##| play (chord :C4, :minor), amp: 0.5, attack: 1, sustain: 2, decay: 3, release: 2, pan: -0.5
    sleep 8
    ##| play (chord :E4, :minor), amp: 0.5, attack: 1, sustain: 2, decay: 3, release: 2, pan: 0.5
    sleep 8
    ##| play (chord :C4, :minor7), amp: 0.5, attack: 1, sustain: 2, decay: 3, release: 1, pan: -0.5
    sleep 8
    ##| play (chord :E4, :minor7), amp: 0.5, attack: 1, sustain: 1, decay: 1, release: 1, pan: 0.1
    sleep 4
    ##| play (chord :B4, :minor7), amp: 0.5, attack: 1, sustain: 1, decay: 1, release: 1, pan: 0.5
    sleep 4
  end
end
