require 'test_helper'

class CollaboratorMailerTest < ActionMailer::TestCase
  test "new_user_collaborator_mailer" do
    mail = CollaboratorMailer.new_user_collaborator_mailer
    assert_equal "New user collaborator mailer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
