require 'test_helper'

class TestAuthAdapter < Test::Unit::TestCase
  def test_undefined_auth_adapter
    flexmock(Socket).should_receive(:tcp).ordered.with('ldap.example.com', 379, { connect_timeout: 5 }).once.and_return(nil)

    conn = Net::LDAP::Connection.new(host: 'ldap.example.com', port: 379)
    assert_raise Net::LDAP::AuthMethodUnsupportedError, "Unsupported auth method (foo)" do
      conn.bind(method: :foo)
    end
  end
end
