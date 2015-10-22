require 'rails_helper'

describe SolrDocument do

  let(:all_fields) do
    %i(id artesia_id aspect_ratio barcode category ci_id clip_description
       clip_keywords clip_title codec digital_wrapper dimensions drive_name
       episode_number event_date event_location file_name folder_name format
       frames_per_second id length origin program series tape_number
       thumb_src time_in type proxy_src watermarked_src)
  end

  # Specify one or more fields to be empty for testing purposes.
  let(:fields_with_empty_vals) { [:barcode] }

  # Create a mock hash that emulates a hash returned from RSolr query.
  let(:hash_from_rsolr) do
    vals = all_fields.map do |field|
      fields_with_empty_vals.include?(field) ? '' : "value of #{field}"
    end

    hash = Hash[all_fields.zip(vals)]
    
    hash_from_rsolr = {
      id: hash[:id],
      json: JSON.pretty_generate(hash),
      text: hash.values
    }
  end

  subject { SolrDocument.new(hash_from_rsolr) }

  describe '#label_for' do
    it 'returns a string for every field' do
      all_fields.each do |field|
        expect(subject.label_for(field)).to be_a String
      end
    end
  end

  describe '#labels_and_values' do
    it 'returns a array of hashes of the form {label: "asset field", value: "asset field value"}' do
      labels_and_values = subject.labels_and_values(*all_fields)
      expect(labels_and_values.map{|pair| pair[:label] }).to eq (all_fields - fields_with_empty_vals).map{ |field| subject.label_for(field) }
      expect(labels_and_values.map{|pair| pair[:value] }).to eq (all_fields - fields_with_empty_vals).map{ |field| subject.send(field) }
    end
  end
end