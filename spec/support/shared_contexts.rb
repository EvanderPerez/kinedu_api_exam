shared_context 'create user for log-in' do
  let(:current_user) { create(:user) }
  let!(:auth_params) { { access_token: current_user.access_token, user_id: current_user.id } }
end

shared_context 'headers for swagger' do
  parameter name: 'access-token', in: :header, type: :string
  parameter name: 'user-id', in: :header, type: :string

  include_context 'set header values'
end

shared_context 'set header values' do
  let("access-token") { auth_params[:access_token] }
  let("user-id") { auth_params[:user_id] }
end

shared_context 'log-in' do
  before do
    user = create(:user)
    @auth_headers = { 
      'HTTP_ACCESS_TOKEN' => user.access_token,
      'HTTP_USER_ID' => user.id
    }
  end
end
