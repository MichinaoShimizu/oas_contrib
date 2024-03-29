require_relative 'spec_helper'

RSpec.describe 'merge command' do
  subject do
    `#{cmd}`
    $?.exitstatus
  end

  let(:cmd) { "bundle exec oas_contrib merge #{indir} #{outfile} #{option}" }

  context 'swagger_v2 yml yml' do
    let(:indir) { 'example/dist/v2' }
    let(:outfile) { '/tmp/rspectestresult/dist.yml' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yml yml' do
    let(:indir) { 'example/dist/v3' }
    let(:outfile) { '/tmp/rspectestresult/dist.yml' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yaml yaml' do
    let(:indir) { 'example/dist/v3' }
    let(:outfile) { '/tmp/rspectestresult/dist.yaml' }
    let(:option) { '--in_ext=.yaml' }
    it { is_expected.to eq(0) }
  end

  context 'swagger_v2 yml json' do
    let(:indir) { 'example/dist/v2' }
    let(:outfile) { '/tmp/rspectestresult/dist.json' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yml json' do
    let(:indir) { 'example/dist/v3' }
    let(:outfile) { '/tmp/rspectestresult/dist.json' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yaml json' do
    let(:indir) { 'example/dist/v3' }
    let(:outfile) { '/tmp/rspectestresult/dist.json' }
    let(:option) { '--in_ext=.yaml' }
    it { is_expected.to eq(0) }
  end
end
