require_relative 'spec_helper'

RSpec.describe 'divide command' do
  subject do
    `#{cmd}`
    $?.exitstatus
  end

  let(:cmd) { "bundle exec oas_contrib divide #{infile} #{outdir} #{option}" }

  context 'swagger_v2 yml yml' do
    let(:infile) { 'example/v2.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yml yml' do
    let(:infile) { 'example/v3.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yaml yaml' do
    let(:infile) { 'example/v3.yaml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_ext=.yaml'}
    it { is_expected.to eq(0) }
  end

  context 'swagger_v2 yml json' do
    let(:infile) { 'example/v2.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_ext=.json' }
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yml json' do
    let(:infile) { 'example/v3.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_ext=.json' }
    it { is_expected.to eq(0) }
  end

  context 'openapi_v3 yaml json' do
    let(:infile) { 'example/v3.yaml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_ext=.json' }
    it { is_expected.to eq(0) }
  end
end
