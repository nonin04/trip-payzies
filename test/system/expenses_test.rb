require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @expense = expenses(:one)
  end

  test "visiting the index" do
    visit expenses_url
    assert_selector "h1", text: "Expenses"
  end

  test "should create expense" do
    visit expenses_url
    click_on "New expense"

    fill_in "Amount", with: @expense.amount
    fill_in "Memo", with: @expense.memo
    fill_in "Participant", with: @expense.participant_id
    fill_in "Payment date", with: @expense.payment_date
    fill_in "Place", with: @expense.place
    fill_in "Title", with: @expense.title
    click_on "Create Expense"

    assert_text "Expense was successfully created"
    click_on "Back"
  end

  test "should update Expense" do
    visit expense_url(@expense)
    click_on "Edit this expense", match: :first

    fill_in "Amount", with: @expense.amount
    fill_in "Memo", with: @expense.memo
    fill_in "Participant", with: @expense.participant_id
    fill_in "Payment date", with: @expense.payment_date
    fill_in "Place", with: @expense.place
    fill_in "Title", with: @expense.title
    click_on "Update Expense"

    assert_text "Expense was successfully updated"
    click_on "Back"
  end

  test "should destroy Expense" do
    visit expense_url(@expense)
    click_on "Destroy this expense", match: :first

    assert_text "Expense was successfully destroyed"
  end
end
