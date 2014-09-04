# Expected values were determined by manually grepping
# through the example application in spec/test_app
describe Serum::Rails::Metrics do

  let(:root) { 'spec/test_app' }

  subject { Serum::Rails::Metrics.new(root) }

  describe '#unescaped_strings' do
    it 'should count the occurrences' do
      expect(subject.unescaped_strings).to eq(17)
    end
  end

  describe '#controller_actions' do
    it 'should count the occurrences' do
      expect(subject.controller_actions).to eq((94 * 0.8).round) # we ignore some fraction for private methods
    end
  end

  describe '#uploaders' do
    it 'should count the occurrences' do
      expect(subject.uploaders).to eq(2)
    end
  end

  describe '#crypto_terms' do
    it 'should count the occurrences' do
      expect(subject.crypto_terms).to eq(17)
    end
  end

  describe '#cookie_accesses' do
    it 'should count the occurrences' do
      expect(subject.cookie_accesses).to eq(5)
    end
  end

  describe '#file_accesses' do
    it 'should count the occurrences' do
      expect(subject.file_accesses).to eq(33)
    end
  end

  describe '#mailer_invocations' do
    it 'should count the occurrences' do
      expect(subject.mailer_invocations).to eq(4)
    end
  end

  describe '#redirects' do
    it 'should count the occurrences' do
      expect(subject.redirects).to eq(15)
    end
  end

  describe '#json_outputs' do
    it 'should count the occurrences' do
      expect(subject.json_outputs).to eq(2)
    end
  end

  describe '#yaml_inputs' do
    it 'should count the occurrences' do
      expect(subject.yaml_inputs).to eq(3)
    end
  end

  describe '#lines_of_code' do
    it 'should count the occurrences' do
      expect(subject.lines_of_code).to eq(12627)
    end
  end

  #describe '#lines_of_ruby_code' do
  #  expect(subject.lines_of_ruby_code).to eq(123)
  #end
  #
  #describe '#lines_of_view_code' do
  #  expect(subject.lines_of_view_code).to eq(123)
  #end
  #
  #describe '#lines_of_javascript_code' do
  #  expect(subject.lines_of_javascript_code).to eq(123)
  #end

end
