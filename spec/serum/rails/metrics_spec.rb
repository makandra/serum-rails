describe Serum::Rails::Metrics do

  let(:root) { 'spec/test_app' }

  subject { Serum::Rails::Metrics.new(root) }

  describe '#unescaped_strings' do
    it 'should count the occurrences' do
      expect(subject.unescaped_strings).to eq(123)
    end
  end

  describe '#controller_actions' do
    it 'should count the occurrences' do
      expect(subject.controller_actions).to eq(123)
    end
  end

  describe '#uploaders' do
    it 'should count the occurrences' do
      expect(subject.uploaders).to eq(123)
    end
  end

  describe '#crypto_terms' do
    it 'should count the occurrences' do
      expect(subject.crypto_terms).to eq(123)
    end
  end

  describe '#cookie_accesses' do
    it 'should count the occurrences' do
      expect(subject.cookie_accesses).to eq(123)
    end
  end

  describe '#file_accesses' do
    it 'should count the occurrences' do
      expect(subject.file_accesses).to eq(123)
    end
  end

  describe '#mailer_invocations' do
    it 'should count the occurrences' do
      expect(subject.mailer_invocations).to eq(123)
    end
  end

  describe '#redirects' do
    it 'should count the occurrences' do
      expect(subject.redirects).to eq(123)
    end
  end

  describe '#json_outputs' do
    it 'should count the occurrences' do
      expect(subject.json_outputs).to eq(123)
    end
  end

  describe '#yaml_inputs' do
    it 'should count the occurrences' do
      expect(subject.yaml_inputs).to eq(123)
    end
  end

  describe '#lines_of_code' do
    it 'should count the occurrences' do
      expect(subject.lines_of_code).to eq(123)
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
