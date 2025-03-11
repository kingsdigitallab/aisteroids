require "csv"

file = File.read("../../data/historical_data.csv")
data = CSV.parse(file, headers: true, header_converters: :symbol)

data.each do |row|
  volume = row[:volume].to_f

  first = row[:open].gsub("\$", "").to_f
  last = row[:last].gsub("\$", "").to_f
  last_open_diff = last - first

  pan = rrand(0, 1)
  if last_open_diff < 0
    pan = rrand(-1, 0)
  end

  low = row[:low].gsub("\$", "").to_f
  high = row[:high].gsub("\$", "").to_f
  high_low_diff = high - low

  notes = [:fs2, :fs3, :fs4, :fs5, :gs1, :gs2, :gs3, :gs4, :gs5]
  note_index = volume % 9
  base_note = notes[note_index]

  note = scale(base_note, :minor_pentatonic, num_octaves: 3).choose

  use_synth(:dsaw)
  with_fx(:slicer, phase: [0.25, 0.125].choose) do
    with_fx(:reverb, room: 0.8, mix: 0.4) do
      play note, release: 2, note_slide: 10, cuttoff: high_low_diff, detune: rrand(0, 0.02), pan: pan, pan_slide: rrand(first / 100, last / 100)
      sleep 0.5
    end
  end
end
