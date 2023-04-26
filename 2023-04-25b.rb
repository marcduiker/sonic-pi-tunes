# Marc Duiker
# 2023-04-25

use_bpm 110


beat_cutoff = (line 130, 110, step: 5)
beat_amp = 0.7    #0.7
bass_amp = 0.7    #0.7
lead_amp = 0     #0.4
pad_amp = 0.4     #0.4
root_note = :f1
bs_cutoff = (line 100, 50, step: 5)

live_loop :bassdrum do
  with_fx :lpf, cutoff: beat_cutoff.tick, amp: beat_amp do
    with_fx :distortion, distort: 0.4 do
      4.times do
        sample :bd_ada, amp: 1.5
        3.times do
          sleep 0.25
          sample :elec_blip, pan: rrand(-0.7, 0.7), amp: 0.5 if one_in(5)
          sample :drum_cymbal_closed, amp: rrand(0.2, 0.5) if one_in(2)
          sample :drum_cymbal_hard, amp: rrand(0.2, 0.3), release: 0.1, amp: 0.4 if one_in(7)
        end
        sample :bd_ada, amp: 1.5 if one_in(3)
        sample :sn_dolf, amp: 0.5
        sleep 0.25
        2.times do
          sample :elec_blip, pan: rrand(-0.7, 0.7), amp: 0.5 if one_in(2)
          sleep 0.25
        end
      end
    end
  end
end

live_loop :bassline do
  bs = scale(root_note, :major_pentatonic, num_octaves: 2)
  seeds = (ring 34563, 345, 53456, 57656)
  use_random_seed seeds.tick
  use_synth :dsaw
  with_fx :reverb, mix: 0.5, damp: 0.1, room: 0.3, amp: bass_amp do
    with_fx :distortion, distort: 0.1, mix: 0.2 do
      16.times do
        play bs.choose, cutoff: bs_cutoff.tick, attack: 0.01, release: 0.2, pan: rrand(-0.1, 0.1)
        sleep 0.25
      end
    end
  end
end

live_loop :lead do
  ld = scale(root_note + 24, :major_pentatonic, num_octaves: 3)
  with_fx :reverb, mix: 0.5, damp: 0.1, room: 0.6, amp: lead_amp do
    8.times do
      synth :dsaw, note: ld.tick, attack: 0.9, release: 1, cutoff: 100, amp: 0.4
      synth :dtri, note: ld.tick, attack: 0.9, release: 1, cutoff: 100, amp: 0.4
      sleep 1
    end
  end
end

live_loop :pad do
  pd = scale(root_note + 24, :major_pentatonic, num_octaves: 1)
  with_fx :gverb, mix: 0.5, room: 50, damp: 0.5, spread: 1, amp: pad_amp do
    use_synth :fm
    play pd.choose, attack: 1, attack_level: 0.4, decay: 1, decay_level: 0.3, sustain: 1, sustain_level: 0.2, release: 3, amp: 1
  end
  with_fx :panslicer, mix: 0.9, amp_min: 0.4, amp_max: 0.8, phase: 1, pan_min: -0.3, pan_max: 0.3, phase_offset: 0.5 do
    with_fx :gverb, mix: 0.5, room: 50, damp: 0.5, spread: 1, amp: pad_amp do
      2.times do
        use_synth :blade
        play pd.choose, attack: 0.5, release: 4
        play pd.choose - 12, attack: 0.6, release: 4.5, amp: 0.7
        sleep 4
      end
    end
  end
end
