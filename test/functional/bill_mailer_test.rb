require 'test_helper'

class BillMailerTest < ActionMailer::TestCase
  test "bill_confirmation" do
    mail = BillMailer.bill_confirmation
    assert_equal "Bill confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
