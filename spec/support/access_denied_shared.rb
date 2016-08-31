RSpec.shared_examples 'user not authorized' do
  context 'denies access to project' do
    it { expect{ action }.to raise_error(CanCan::AccessDenied) }
  end
end