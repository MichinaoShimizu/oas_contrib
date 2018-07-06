require_relative 'spec_helper'

RSpec.describe 'divide command' do
  subject do
    `#{cmd}`
    $?.exitstatus
  end
  let(:cmd) { "bundle exec oas_contrib divide #{infile} #{outdir} #{option}" }
  context 'swagger_v2 yaml yaml' do
    let(:infile) { 'example/sample_petstore_swagger_v2.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end
  context 'openapi_v3 yaml yaml' do
    let(:infile) { 'example/sample_petstore_openapi_v3.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) {}
    it { is_expected.to eq(0) }
  end
  context 'swagger_v2 yaml json' do
    let(:infile) { 'example/sample_petstore_swagger_v2.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_type=json' }
    it { is_expected.to eq(0) }
  end
  context 'openapi_v3 yaml json' do
    let(:infile) { 'example/sample_petstore_openapi_v3.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_type=json' }
    it { is_expected.to eq(0) }
  end
  context 'invalid out_type hoge' do
    let(:infile) { 'example/sample_petstore_openapi_v3.yml' }
    let(:outdir) { '/tmp/rspectestresult' }
    let(:option) { '--out_type=hoge' }
    it { is_expected.to eq(1) }
  end
end
