# Marc Duiker
# 2023-04-25

use_bpm 120

bd = (ring 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1)
clh = (ring 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
clo = (ring 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0)
sn = (ring 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1)

beat_cutoff = (line 130, 80, step: 5)
beat_amp = 0.6
drone_amp = 0.8
pad_amp = 0.6
root_note = :f1
bs_cutoff = (line 100, 80, step: 5)

live_loop :bassdrum do
  with_fx :lpf, cutoff: beat_cutoff.tick, amp: beat_amp do
    4.times do
      if bd.tick == 1
        sample :bd_ada, amp: 1.5
      end
      sleep 0.25
    end
  end
end

live_loop :snare do
  with_fx :lpf, cutoff: beat_cutoff.tick, amp: beat_amp do
    4.times do
      if sn.tick == 1
        sample :sn_dolf, amp: 0.5
      end
      sleep 0.25
    end
  end
end

live_loop :hihat_closed do
  with_fx :lpf, cutoff: beat_cutoff.tick, amp: beat_amp do
    4.times do
      if clh.tick == 1
        sample :drum_cymbal_closed, amp: rrand(0.2, 0.5)
      end
      sleep 0.25
    end
  end
end

live_loop :hihat_open do
  with_fx :lpf, cutoff: beat_cutoff.tick, amp: beat_amp do
    4.times do
      if clo.tick == 1
        sample :drum_cymbal_hard, amp: rrand(0.2, 0.3), release: 0.1
      end
      sleep 0.25
    end
  end
end

live_loop :bassline do
  bs = scale(root_note, :major_pentatonic, num_octaves: 2)
  seeds = (ring 30, 20, 50, 10)
  use_random_seed seeds.tick
  use_synth :dsaw
  with_fx :reverb, mix: 0.5, damp: 0.1, room: 0.3, amp: drone_amp do
    with_fx :distortion, distort: 0.1, mix: 0.2 do
      4.times do
        play bs.choose, cutoff: bs_cutoff.tick, attack: 0.01, release: 0.2, pan: rrand(-0.1, 0.1)
        sleep 0.25
      end
    end
  end
end

live_loop :pad do
  use_synth :blade
  ld = scale(root_note + 24, :major_pentatonic, num_octaves: 1)
  with_fx :panslicer, mix: 0.9, amp_min: 0.4, amp_max: 0.8, phase: 1, pan_min: -0.3, pan_max: 0.3, phase_offset: 0.5 do
    with_fx :gverb, mix: 0.5, room: 50, damp: 0.5, spread: 1, amp: pad_amp do
      2.times do
        play ld.choose, attack: 0.5, release: 4
        play ld.choose - 12, attack: 0.6, release: 4.5, amp: 0.7
        sleep 4
      end
    end
  end
end
