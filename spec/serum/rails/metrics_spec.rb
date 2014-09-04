# Expected values were determined by manually grepping
# through the example application in spec/test_app
describe Serum::Rails::Metrics do

  let(:rails_2_3_metrics) { Serum::Rails::Metrics.new('spec/test_apps/rails-2-3') }
  let(:rails_4_1_metrics) { Serum::Rails::Metrics.new('spec/test_apps/rails-4-1') }

  describe '#routes' do
    it 'should count the occurrences' do
      expect(rails_4_1_metrics.routes).to eq(11)
    end
  end

  describe '#gems' do
    it 'should count the occurrences' do
      expect(rails_4_1_metrics.gems).to eq(47)
    end
  end

  describe '#unescaped_strings' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.unescaped_strings).to eq(17)
    end
  end

  describe '#controller_methods' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.controller_methods).to eq(94)
    end
  end

  describe '#uploaders' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.uploaders).to eq(2)
    end
  end

  describe '#crypto_terms' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.crypto_terms).to eq(17)
    end
  end

  describe '#cookie_accesses' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.cookie_accesses).to eq(5)
    end
  end

  describe '#file_accesses' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.file_accesses).to eq(33)
    end
  end

  describe '#mailer_invocations' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.mailer_invocations).to eq(4)
    end
  end

  describe '#redirects' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.redirects).to eq(15)
    end
  end

  describe '#json_outputs' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.json_outputs).to eq(2)
    end
  end

  describe '#yaml_inputs' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.yaml_inputs).to eq(3)
    end
  end

  describe '#lines_of_code' do
    it 'should count the occurrences' do
      expect(rails_2_3_metrics.lines_of_code).to eq(12627)
    end
  end

  #describe '#lines_of_ruby_code' do
  #  expect(rails_2_3_metrics.lines_of_ruby_code).to eq(123)
  #end
  #
  #describe '#lines_of_view_code' do
  #  expect(rails_2_3_metrics.lines_of_view_code).to eq(123)
  #end
  #
  #describe '#lines_of_javascript_code' do
  #  expect(rails_2_3_metrics.lines_of_javascript_code).to eq(123)
  #end

end
